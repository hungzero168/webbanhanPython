from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import login, authenticate, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.contrib import messages
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
from django.db.models import Q, Avg, Case, When, IntegerField
from django.http import JsonResponse
from django.utils import timezone
from django.urls import reverse
from django.db import transaction
from .models import (
    Product, Category, Order, OrderItem, Cart, CartItem, 
    Review, UserProfile, Wishlist, Coupon
)
from decimal import Decimal

def get_base_context(request):
    """Get base context for all views"""
    cart_count = get_cart_count(request)
    categories = Category.objects.all()
    return {
        'cart_count': cart_count,
        'categories': categories
    }

def home(request):
    # Lấy sản phẩm nổi bật
    featured_products = Product.objects.filter(
        is_available=True,
        featured=True
    ).order_by('-created_at')[:8]

    # Sản phẩm mới
    new_products = Product.objects.filter(
        is_available=True
    ).order_by('-created_at')[:4]

    # Sản phẩm bán chạy
    best_sellers = Product.objects.filter(
        is_available=True
    ).order_by('-sold')[:4]

    # Sản phẩm được đánh giá cao
    top_rated = Product.objects.filter(
        is_available=True,
        reviews__isnull=False
    ).annotate(
        avg_rating=Avg('reviews__rating')
    ).order_by('-avg_rating')[:4]

    # Lấy danh sách wishlist nếu user đã đăng nhập
    wishlist_products = []
    if request.user.is_authenticated:
        wishlist_products = Product.objects.filter(wishlist__user=request.user)

    # Lấy tất cả danh mục đang active
    categories = Category.objects.filter(is_active=True)

    context = {
        'featured_products': featured_products,
        'new_products': new_products, 
        'best_sellers': best_sellers,
        'top_rated': top_rated,
        'cart_count': get_cart_count(request),
        'wishlist_products': wishlist_products,
        'categories': categories
    }
    return render(request, 'home.html', context)

def products(request):
    # Lấy query từ form tìm kiếm
    query = request.GET.get('q', '')
    products = Product.objects.filter(is_available=True)
    
    # Tìm kiếm theo query nếu có
    if query:
        products = products.filter(
            Q(name__icontains=query) |  # Tìm trong tên
            Q(description__icontains=query) |  # Tìm trong mô tả
            Q(category__name__icontains=query) |  # Tìm trong tên danh mục
            Q(specifications__icontains=query)  # Tìm trong thông số kỹ thuật
        ).distinct()  # Loại bỏ kết quả trùng lặp
    
    # Get user's wishlist products
    wishlist_products = []
    if request.user.is_authenticated:
        wishlist_products = Product.objects.filter(wishlist__user=request.user)
    
    # Filter by category
    category_id = request.GET.get('category')
    if category_id:
        products = products.filter(category_id=category_id)
    
    # Sắp xếp sản phẩm
    sort = request.GET.get('sort', 'relevance')  # Mặc định sắp xếp theo độ phù hợp
    if sort == 'price_asc':
        products = products.order_by('price')
    elif sort == 'price_desc':
        products = products.order_by('-price')
    elif sort == 'name_asc':
        products = products.order_by('name')
    elif sort == 'name_desc':
        products = products.order_by('-name')
    elif sort == 'newest':
        products = products.order_by('-created_at')
    elif sort == 'relevance' and query:  # Sắp xếp theo độ phù hợp khi có từ khóa tìm kiếm
        products = products.annotate(
            relevance=Case(
                When(name__icontains=query, then=4),  # Ưu tiên kết quả có từ khóa trong tên
                When(category__name__icontains=query, then=3),  # Ưu tiên kết quả có từ khóa trong danh mục
                When(description__icontains=query, then=2),  # Ưu tiên kết quả có từ khóa trong mô tả
                When(specifications__icontains=query, then=1),  # Ưu tiên kết quả có từ khóa trong thông số
                default=0,
                output_field=IntegerField(),
            )
        ).order_by('-relevance', '-created_at')
    
    # Phân trang
    paginator = Paginator(products, 12)  # 12 sản phẩm mỗi trang
    page = request.GET.get('page')
    try:
        products = paginator.page(page)
    except PageNotAnInteger:
        products = paginator.page(1)
    except EmptyPage:
        products = paginator.page(paginator.num_pages)
    
    # Lấy tất cả danh mục
    categories = Category.objects.filter(is_active=True)
    
    context = {
        'products': products,
        'categories': categories,
        'selected_category': category_id,
        'query': query,
        'sort': sort,
        'wishlist_products': wishlist_products,
    }
    
    return render(request, 'products.html', context)

@login_required
def add_to_wishlist(request, product_id):
    if request.method == 'POST':
        try:
            wishlist_item = Wishlist.objects.get(
                user=request.user,
                product_id=product_id
            )
            wishlist_item.delete()
            return JsonResponse({'success': True, 'action': 'removed'})
        except Wishlist.DoesNotExist:
            Wishlist.objects.create(
                user=request.user,
                product_id=product_id
            )
            return JsonResponse({'success': True, 'action': 'added'})
    return JsonResponse({'success': False})

@login_required
def add_review(request, product_id):
    if request.method == 'POST':
        product = get_object_or_404(Product, id=product_id)
        rating = request.POST.get('rating')
        comment = request.POST.get('comment')
        images = request.FILES.get('images')

        # Tạo review mới
        review = Review.objects.create(
            user=request.user,
            product=product,
            rating=rating,
            comment=comment,
            images=images
        )

        messages.success(request, 'Cảm ơn bạn đã đánh giá sản phẩm!')
        return redirect('product_detail', id=product_id)

    return redirect('product_detail', id=product_id)

@login_required
def apply_coupon(request):
    if request.method == 'POST':
        code = request.POST.get('code')
        try:
            # Kiểm tra mã giảm giá có tồn tại và còn hiệu lực
            coupon = Coupon.objects.get(
                code=code,
                active=True,
                valid_from__lte=timezone.now(),
                valid_to__gte=timezone.now()
            )
            
            # Lấy giỏ hàng hiện tại
            cart = Cart.objects.get(user=request.user)
            cart_items = CartItem.objects.filter(cart=cart)
            
            if not cart_items.exists():
                return JsonResponse({
                    'success': False,
                    'message': 'Giỏ hàng trống'
                })
            
            # Tính tổng tiền giỏ hàng
            subtotal = sum(item.total_price for item in cart_items)
            
            # Kiểm tra điều kiện áp dụng
            if subtotal < coupon.minimum_amount:
                return JsonResponse({
                    'success': False,
                    'message': f'Đơn hàng tối thiểu {coupon.minimum_amount:,}đ'
                })
            
            # Tính giảm giá
            discount = min(coupon.discount, subtotal)  # Không giảm quá tổng tiền
            
            # Lưu mã giảm giá vào session
            request.session['coupon_id'] = coupon.id
            request.session['discount'] = float(discount)
            
            return JsonResponse({
                'success': True,
                'message': 'Áp dụng mã giảm giá thành công',
                'cart_total': subtotal,
                'discount': discount
            })
            
        except Coupon.DoesNotExist:
            return JsonResponse({
                'success': False,
                'message': 'Mã giảm giá không hợp lệ hoặc đã hết hạn'
            })
            
    return JsonResponse({
        'success': False,
        'message': 'Invalid request method'
    })

def get_cart_count(request):
    if request.user.is_authenticated:
        try:
            cart = Cart.objects.get(user=request.user)
            return CartItem.objects.filter(cart=cart).count()
        except Cart.DoesNotExist:
            return 0
    return 0

def login_view(request):
    # Nếu đã đăng nhập thì chuyển về trang chủ
    if request.user.is_authenticated:
        return redirect('home')
    
    context = get_base_context(request)
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        
        if user is not None:
            login(request, user)
            return redirect('home')
        else:
            context['error'] = 'Tên đăng nhập hoặc mật khẩu không đúng'
    return render(request, 'login.html', context)

def register_view(request):
    # Nếu đã đăng nhập thì chuyển về trang chủ
    if request.user.is_authenticated:
        return redirect('home')
        
    context = get_base_context(request)
    if request.method == 'POST':
        username = request.POST.get('username')
        email = request.POST.get('email')
        password1 = request.POST.get('password1')
        password2 = request.POST.get('password2')
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        phone = request.POST.get('phone')
        
        if password1 != password2:
            context['error'] = 'Mật khẩu không khớp'
            return render(request, 'register.html', context)
        
        if User.objects.filter(username=username).exists():
            return render(request, 'register.html', {'error': 'Tên đăng nhập đã tồn tại'})
        
        if User.objects.filter(email=email).exists():
            return render(request, 'register.html', {'error': 'Email đã được sử dụng'})
        
        try:
            with transaction.atomic():  # Sử dụng transaction để đảm bảo tính nhất quán
                # Tạo user
                user = User.objects.create_user(
                    username=username,
                    email=email,
                    password=password1,
                    first_name=first_name,
                    last_name=last_name
                )
                
                # Tạo profile nếu chưa có
                profile, created = UserProfile.objects.get_or_create(
                    user=user,
                    defaults={'phone': phone}
                )
                
                if not created:
                    profile.phone = phone
                    profile.save()
                
                login(request, user)
                return redirect('home')
                
        except Exception as e:
            return render(request, 'register.html', {'error': str(e)})
    
    return render(request, 'register.html', context)

@login_required
def cart_view(request):
    try:
        cart = Cart.objects.get(user=request.user)
        cart_items = CartItem.objects.filter(cart=cart)
        
        subtotal = sum(item.total_price for item in cart_items)
        discount = 0  # Tính giảm giá nếu có
        total = subtotal - discount
        
        context = {
            **get_base_context(request),
            'cart_items': cart_items,
            'subtotal': subtotal,
            'discount': discount,
            'total': total
        }
        return render(request, 'cart.html', context)
    except Cart.DoesNotExist:
        context = {
            **get_base_context(request),
            'cart_items': None
        }
        return render(request, 'cart.html', context)

def product_detail(request, id):
    try:
        product = Product.objects.get(id=id, is_available=True)
        
        # Kiểm tra sản phẩm có trong wishlist không
        is_in_wishlist = False
        if request.user.is_authenticated:
            is_in_wishlist = Wishlist.objects.filter(
                user=request.user,
                product=product
            ).exists()
            
        context = {
            **get_base_context(request),
            'product': product,
            'is_in_wishlist': is_in_wishlist
        }
        return render(request, 'product_detail.html', context)
    except Product.DoesNotExist:
        messages.error(request, 'Sản phẩm không tồn tại hoặc đã bị xóa')
        return redirect('products')

def about_view(request):
    return render(request, 'about.html')

def news_view(request):
    return render(request, 'news.html')

def contact_view(request):
    return render(request, 'contact.html')

@login_required
def profile_view(request):
    profile, created = UserProfile.objects.get_or_create(user=request.user)
    
    try:
        orders = Order.objects.filter(user=request.user).order_by('-created_at')
    except Order.DoesNotExist:
        orders = []
        
    try:
        wishlist = Wishlist.objects.filter(user=request.user)
    except Wishlist.DoesNotExist:
        wishlist = []
    
    context = {
        'orders': orders,
        'user': request.user,
        'profile': profile,
        'wishlist': wishlist,
        'cart_count': get_cart_count(request)
    }
    return render(request, 'profile.html', context)

@login_required
def profile_update(request):
    if request.method == 'POST':
        # Kiểm tra các trường bắt buộc
        required_fields = {
            'first_name': 'Họ',
            'last_name': 'Tên',
            'phone': 'Số điện thoại',
            'address': 'Địa chỉ'
        }
        
        for field, name in required_fields.items():
            if not request.POST.get(field):
                messages.error(request, f'Vui lòng nhập {name}')
                return redirect('profile')
        
        # Kiểm tra định dạng số điện thoại
        phone = request.POST.get('phone')
        if not phone.isdigit() or len(phone) != 10:
            messages.error(request, 'Số điện thoại không hợp lệ')
            return redirect('profile')
            
        user = request.user
        user.first_name = request.POST.get('first_name')
        user.last_name = request.POST.get('last_name')
        user.save()
        
        # Cập nhật profile
        profile, created = UserProfile.objects.get_or_create(user=user)
        
        if request.FILES.get('avatar'):
            if profile.avatar:
                profile.avatar.delete(save=False)
            profile.avatar = request.FILES['avatar']
            
        profile.phone = phone
        profile.address = request.POST.get('address')
        profile.gender = request.POST.get('gender')
        profile.birth_date = request.POST.get('birth_date') or None
        profile.newsletter = request.POST.get('newsletter') == 'on'
        
        profile.save()
        
        messages.success(request, 'Cập nhật thông tin thành công!')
        return redirect('profile')
        
    return redirect('profile')

@login_required
def change_password(request):
    if request.method == 'POST':
        old_password = request.POST.get('old_password')
        new_password1 = request.POST.get('new_password1')
        new_password2 = request.POST.get('new_password2')
        
        if not request.user.check_password(old_password):
            messages.error(request, 'Mật khẩu hiện tại không đúng')
        elif new_password1 != new_password2:
            messages.error(request, 'Mật khẩu mới không khớp')
        else:
            request.user.set_password(new_password1)
            request.user.save()
            messages.success(request, 'Đổi mật khẩu thành công')
            return redirect('login')
            
    return redirect('profile')

@login_required
def orders_view(request):
    return render(request, 'orders.html')

def logout_view(request):
    logout(request)
    return redirect('home')

def search_view(request):
    query = request.GET.get('q', '')
    category_id = request.GET.get('category', '')
    sort = request.GET.get('sort', '')
    
    # Tìm kiếm sản phẩm
    products = Product.objects.filter(is_available=True)
    
    if query:
        products = products.filter(
            Q(name__icontains=query) |
            Q(description__icontains=query) |
            Q(category__name__icontains=query)
        )
    
    # Lọc theo danh mục
    if category_id:
        products = products.filter(category_id=category_id)
    
    # Sắp xếp
    if sort == 'price_asc':
        products = products.order_by('price')
    elif sort == 'price_desc':
        products = products.order_by('-price')
    elif sort == 'name_asc':
        products = products.order_by('name')
    elif sort == 'name_desc':
        products = products.order_by('-name')
    elif sort == 'newest':
        products = products.order_by('-created_at')
    
    # Phân trang
    paginator = Paginator(products, 12)
    page = request.GET.get('page')
    products = paginator.get_page(page)
    
    # Lấy danh sách wishlist nếu user đã đăng nhập
    wishlist_products = []
    if request.user.is_authenticated:
        wishlist_products = Product.objects.filter(wishlist__user=request.user)
    
    context = {
        'products': products,
        'query': query,
        'selected_category': category_id,
        'sort': sort,
        'categories': Category.objects.filter(is_active=True),
        'wishlist_products': wishlist_products,
        'cart_count': get_cart_count(request)
    }
    
    return render(request, 'search.html', context)

@login_required
def remove_from_wishlist(request, id):
    if request.method == 'POST':
        try:
            wishlist_item = Wishlist.objects.get(id=id, user=request.user)
            wishlist_item.delete()
            return JsonResponse({'success': True})
        except Wishlist.DoesNotExist:
            return JsonResponse({'success': False})
    return JsonResponse({'success': False})

@login_required
def remove_review(request, id):
    if request.method == 'POST':
        try:
            review = Review.objects.get(id=id, user=request.user)
            # Xóa ảnh review nếu có
            if review.images:
                review.images.delete()
            review.delete()
            return JsonResponse({'success': True})
        except Review.DoesNotExist:
            return JsonResponse({'success': False})
    return JsonResponse({'success': False})

@login_required
def toggle_wishlist(request, product_id):
    if request.method == 'POST':
        try:
            # Kiểm tra xem sản phẩm đã có trong wishlist chưa
            wishlist_item = Wishlist.objects.filter(
                user=request.user,
                product_id=product_id
            ).first()
            
            if wishlist_item:
                # Nếu có rồi thì xóa đi
                wishlist_item.delete()
                return JsonResponse({
                    'success': True,
                    'action': 'removed',
                    'message': 'Đã xóa khỏi danh sách yêu thích'
                })
            else:
                # Nếu chưa có thì thêm vào
                Wishlist.objects.create(
                    user=request.user,
                    product_id=product_id
                )
                return JsonResponse({
                    'success': True,
                    'action': 'added',
                    'message': 'Đã thêm vào danh sách yêu thích'
                })
                
        except Exception as e:
            return JsonResponse({
                'success': False,
                'message': str(e)
            })
            
    return JsonResponse({
        'success': False,
        'message': 'Invalid request method'
    })

@login_required
def add_to_cart(request, product_id):
    if request.method == 'POST':
        try:
            quantity = int(request.POST.get('quantity', 1))
            product = get_object_or_404(Product, id=product_id, is_available=True)
            
            # Kiểm tra số lượng tồn kho
            if product.stock < quantity:
                return JsonResponse({
                    'success': False,
                    'message': f'Chỉ còn {product.stock} sản phẩm trong kho'
                })
            
            # Lấy hoặc tạo giỏ hàng
            cart, _ = Cart.objects.get_or_create(user=request.user)
            
            # Kiểm tra sản phẩm đã có trong giỏ chưa
            cart_item, created = CartItem.objects.get_or_create(
                cart=cart,
                product=product,
                defaults={'quantity': quantity}
            )
            
            # Nếu sản phẩm đã có trong giỏ thì cộng thêm số lượng
            if not created:
                cart_item.quantity += quantity
                if cart_item.quantity > product.stock:
                    cart_item.quantity = product.stock
                cart_item.save()
            
            cart_count = sum(item.quantity for item in cart.items.all())
            
            return JsonResponse({
                'success': True,
                'message': 'Đã thêm sản phẩm vào giỏ hàng',
                'cart_count': cart_count
            })
            
        except Product.DoesNotExist:
            return JsonResponse({
                'success': False,
                'message': 'Sản phẩm không tồn tại'
            })
        except Exception as e:
            return JsonResponse({
                'success': False,
                'message': str(e)
            })
    
    return JsonResponse({
        'success': False,
        'message': 'Invalid request method'
    })

@login_required
def update_cart_item(request, item_id):
    if request.method == 'POST':
        try:
            quantity = int(request.POST.get('quantity', 1))
            cart_item = CartItem.objects.get(id=item_id, cart__user=request.user)
            
            # Kiểm tra số lượng tồn kho
            if cart_item.product.stock < quantity:
                return JsonResponse({
                    'success': False,
                    'message': f'Chỉ còn {cart_item.product.stock} sản phẩm trong kho',
                    'current_quantity': cart_item.quantity
                })
                
            cart_item.quantity = quantity
            cart_item.save()
            
            # Tính lại tổng tiền giỏ hàng
            cart_items = CartItem.objects.filter(cart=cart_item.cart)
            cart_total = sum(item.total_price for item in cart_items)
            
            # Kiểm tra lại điều kiện mã giảm giá
            coupon_id = request.session.get('coupon_id')
            if coupon_id:
                try:
                    coupon = Coupon.objects.get(id=coupon_id)
                    if cart_total < coupon.minimum_amount:
                        del request.session['coupon_id']
                        del request.session['discount']
                        discount = 0
                    else:
                        discount = float(request.session.get('discount', 0))
                except Coupon.DoesNotExist:
                    discount = 0
            else:
                discount = 0
            
            return JsonResponse({
                'success': True,
                'message': 'Đã cập nhật giỏ hàng',
                'item_total': cart_item.total_price,
                'cart_total': cart_total,
                'discount': discount
            })
            
        except CartItem.DoesNotExist:
            return JsonResponse({
                'success': False,
                'message': 'Sản phẩm không có trong giỏ hàng'
            })
            
    return JsonResponse({
        'success': False,
        'message': 'Invalid request method'
    })

@login_required
def remove_cart_item(request, item_id):
    if request.method == 'POST':
        try:
            cart_item = CartItem.objects.get(id=item_id, cart__user=request.user)
            cart = cart_item.cart
            cart_item.delete()
            
            # Tính lại tổng tiền
            cart_items = CartItem.objects.filter(cart=cart)
            cart_total = sum(item.total_price for item in cart_items)
            
            # Kiểm tra lại điều kiện mã giảm giá
            coupon_id = request.session.get('coupon_id')
            if coupon_id:
                try:
                    coupon = Coupon.objects.get(id=coupon_id)
                    if cart_total < coupon.minimum_amount:
                        del request.session['coupon_id']
                        del request.session['discount']
                        discount = 0
                    else:
                        discount = float(request.session.get('discount', 0))
                except Coupon.DoesNotExist:
                    discount = 0
            else:
                discount = 0
            
            return JsonResponse({
                'success': True,
                'message': 'Đã xóa sản phẩm khỏi giỏ hàng',
                'cart_total': cart_total,
                'discount': discount,
                'cart_count': cart_items.count()
            })
            
        except CartItem.DoesNotExist:
            return JsonResponse({
                'success': False,
                'message': 'Sản phẩm không có trong giỏ hàng'
            })
            
    return JsonResponse({
        'success': False,
        'message': 'Invalid request method'
    })

@login_required
def checkout_view(request):
    try:
        cart = Cart.objects.get(user=request.user)
        cart_items = CartItem.objects.filter(cart=cart)
        
        if not cart_items.exists():
            messages.warning(request, 'Giỏ hàng trống')
            return redirect('cart')
            
        # Lấy thông tin người dùng
        user = request.user
        profile = UserProfile.objects.get_or_create(user=user)[0]
        
        # Tính toán giá trị đơn hàng
        subtotal = sum(item.total_price for item in cart_items)
        discount = Decimal(str(request.session.get('discount', '0')))
        coupon_id = request.session.get('coupon_id')
        
        # Kiểm tra mã giảm giá
        if coupon_id:
            try:
                coupon = Coupon.objects.get(
                    id=coupon_id,
                    active=True,
                    valid_from__lte=timezone.now(),
                    valid_to__gte=timezone.now()
                )
                if subtotal < coupon.minimum_amount:
                    discount = Decimal('0')
                    del request.session['coupon_id']
                    del request.session['discount']
            except Coupon.DoesNotExist:
                discount = Decimal('0')
                del request.session['coupon_id']
                del request.session['discount']
        
        total = subtotal - discount
        
        context = {
            **get_base_context(request),
            'cart_items': cart_items,
            'subtotal': subtotal,
            'discount': discount,
            'total': total,
            'has_coupon': bool(coupon_id),
            'user': user,
            'profile': profile
        }
        return render(request, 'checkout.html', context)
        
    except Cart.DoesNotExist:
        messages.warning(request, 'Giỏ hàng trống')
        return redirect('cart')

@login_required
def place_order(request):
    if request.method == 'POST':
        try:
            # Lấy thông tin từ form
            fullname = request.POST.get('fullname')
            phone = request.POST.get('phone')
            province_code = request.POST.get('province')  # API trả về mã tỉnh
            district_code = request.POST.get('district')  # API trả về mã huyện
            ward_code = request.POST.get('ward')         # API trả về mã xã
            address_detail = request.POST.get('address_detail')
            full_address = request.POST.get('full_address')
            payment_method = request.POST.get('payment_method')
            note = request.POST.get('note', '')
            
            # Lấy giỏ hàng
            cart = Cart.objects.get(user=request.user)
            cart_items = CartItem.objects.filter(cart=cart)
            
            if not cart_items.exists():
                messages.error(request, 'Giỏ hàng trống')
                return redirect('cart')
            
            # Tính tổng tiền
            subtotal = sum(item.total_price for item in cart_items)
            discount = Decimal(str(request.session.get('discount', '0')))
            total = subtotal - discount
            
            # Tạo đơn hàng
            order = Order.objects.create(
                user=request.user,
                order_number=f'ORD{timezone.now().strftime("%Y%m%d%H%M%S")}',
                full_name=fullname,
                phone=phone,
                address=full_address,
                province_code=province_code,     # Sử dụng mã code
                district_code=district_code,     # Sử dụng mã code
                ward_code=ward_code,            # Sử dụng mã code
                payment_method=payment_method,
                note=note,
                subtotal=subtotal,
                discount=discount,
                total_amount=total,
                status='pending',
                payment_status='pending'
            )

            # Lưu coupon nếu có
            coupon_id = request.session.get('coupon_id')
            if coupon_id:
                try:
                    coupon = Coupon.objects.get(id=coupon_id)
                    order.coupon = coupon
                    order.save()
                except Coupon.DoesNotExist:
                    pass
            
            # Tạo chi tiết đơn hàng
            for item in cart_items:
                OrderItem.objects.create(
                    order=order,
                    product=item.product,
                    quantity=item.quantity,
                    price=item.unit_price
                )
                
                # Cập nhật số lượng tồn kho
                product = item.product
                product.stock -= item.quantity
                product.sold += item.quantity
                product.save()
            
            # Xóa giỏ hàng và mã giảm giá
            cart_items.delete()
            if 'coupon_id' in request.session:
                del request.session['coupon_id']
                del request.session['discount']
            
            messages.success(request, 'Đặt hàng thành công!')
            return JsonResponse({
                'success': True,
                'redirect_url': reverse('order_detail', args=[order.order_number])
            })
            
        except Exception as e:
            return JsonResponse({
                'success': False,
                'message': f'Có lỗi xảy ra: {str(e)}'
            })
            
    return JsonResponse({
        'success': False,
        'message': 'Invalid request method'
    })

@login_required
def order_detail(request, order_number):
    try:
        order = Order.objects.get(order_number=order_number, user=request.user)
        context = {
            **get_base_context(request),
            'order': order,
            'order_items': order.items.all()
        }
        return render(request, 'order_detail.html', context)
    except Order.DoesNotExist:
        messages.error(request, 'Không tìm thấy đơn hàng')
        return redirect('profile')
