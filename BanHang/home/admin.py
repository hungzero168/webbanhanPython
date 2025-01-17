from django.contrib import admin
from django.utils.html import format_html
from .models import (
    Product, Category, Order, OrderItem, UserProfile, 
    Cart, CartItem, Review, Wishlist, Coupon
)
from django import forms
from django.db import models

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'description')
    search_fields = ('name', 'description')
    ordering = ('name',)
    readonly_fields = ('slug',)

@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ('image_preview', 'name', 'category', 'formatted_price', 'stock', 'is_available')
    list_filter = ('category', 'is_available', 'created_at')
    search_fields = ('name', 'description')
    list_editable = ('stock', 'is_available')
    readonly_fields = ('created_at', 'updated_at', 'image_preview_large', 'slug')
    
    fieldsets = (
        ('Thông tin cơ bản', {
            'fields': ('name', 'slug', 'category', 'description')
        }),
        ('Giá & Kho', {
            'fields': (('price', 'old_price'), 'stock', 'is_available')
        }),
        ('Hình ảnh', {
            'fields': ('image', 'image_preview_large')
        }),
        ('Thời gian', {
            'fields': ('created_at', 'updated_at'),
            'classes': ('collapse',)
        }),
    )
    
    def image_preview(self, obj):
        if obj.image:
            return format_html('<img src="{}" style="width: 50px; height: 50px; object-fit: cover; border-radius: 5px;">', obj.image.url)
        return "No Image"
    image_preview.short_description = 'Ảnh'

    def image_preview_large(self, obj):
        if obj.image:
            return format_html('<img src="{}" style="max-width: 300px; border-radius: 8px;">', obj.image.url)
        return "No Image"
    image_preview_large.short_description = 'Xem trước ảnh'

    def formatted_price(self, obj):
        return format_html('{}', '{:,.0f} đ'.format(float(obj.price)))
    formatted_price.short_description = 'Giá'

class OrderItemInline(admin.TabularInline):
    model = OrderItem
    extra = 0
    readonly_fields = ('product', 'quantity', 'price')

class OrderAdminForm(forms.ModelForm):
    status = forms.ChoiceField(
        choices=[
            ('pending', 'Chờ xử lý'),
            ('confirmed', 'Đã xác nhận'),
            ('shipping', 'Đang giao hàng'),
            ('completed', 'Đã giao hàng'),
            ('cancelled', 'Đã hủy'),
        ],
        widget=forms.Select(attrs={'class': 'form-select'})
    )
    
    payment_status = forms.ChoiceField(
        choices=[
            ('pending', 'Chờ thanh toán'),
            ('paid', 'Đã thanh toán'),
            ('refunded', 'Đã hoàn tiền'),
        ],
        widget=forms.Select(attrs={'class': 'form-select'})
    )
    
    payment_method = forms.ChoiceField(
        choices=[
            ('cod', 'Thanh toán khi nhận hàng'),
            ('bank', 'Chuyển khoản ngân hàng'),
            ('momo', 'Ví MoMo'),
        ],
        widget=forms.Select(attrs={'class': 'form-select'})
    )
    
    class Meta:
        model = Order
        fields = '__all__'

@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ('order_number', 'user', 'full_name', 'total_amount_display', 'status', 'payment_status', 'created_at')
    list_filter = ('status', 'payment_status', 'payment_method', 'created_at')
    list_editable = ('status', 'payment_status')
    search_fields = ('order_number', 'user__username', 'full_name', 'phone')
    readonly_fields = ('created_at', 'updated_at', 'order_number', 'total_amount_display')
    inlines = [OrderItemInline]
    
    def formfield_for_dbfield(self, db_field, **kwargs):
        formfield = super().formfield_for_dbfield(db_field, **kwargs)
        if db_field.name == "status":
            formfield.widget = forms.Select(choices=[
                ('pending', 'Chờ xử lý'),
                ('confirmed', 'Đã xác nhận'),
                ('shipping', 'Đang giao hàng'),
                ('completed', 'Đã giao hàng'),
                ('cancelled', 'Đã hủy'),
            ])
        elif db_field.name == "payment_status":
            formfield.widget = forms.Select(choices=[
                ('pending', 'Chờ thanh toán'),
                ('paid', 'Đã thanh toán'),
                ('refunded', 'Đã hoàn tiền'),
            ])
        elif db_field.name == "payment_method":
            formfield.widget = forms.Select(choices=[
                ('cod', 'Thanh toán khi nhận hàng'),
                ('bank', 'Chuyển khoản ngân hàng'),
                ('momo', 'Ví MoMo'),
            ])
        return formfield

    fieldsets = (
        ('Thông tin đơn hàng', {
            'fields': (
                'order_number', 'user', 'status',
                ('subtotal', 'discount', 'total_amount', 'total_amount_display'),
                ('payment_method', 'payment_status'),
                'coupon'
            )
        }),
        ('Thông tin khách hàng', {
            'fields': (
                'full_name', 'phone',
                'address',
                ('province_code', 'district_code', 'ward_code')
            )
        }),
        ('Ghi chú', {
            'fields': ('note',)
        }),
        ('Thời gian', {
            'fields': ('created_at', 'updated_at'),
            'classes': ('collapse',)
        }),
    )

    def total_amount_display(self, obj):
        return format_html('{} đ', '{:,.0f}'.format(obj.total_amount))
    total_amount_display.short_description = 'Tổng tiền'
    
    def status_display(self, obj):
        status_dict = dict(self.STATUS_CHOICES)
        status_class = {
            'pending': 'warning',
            'confirmed': 'info',
            'shipping': 'primary',
            'completed': 'success',
            'cancelled': 'danger'
        }
        return format_html(
            '<span class="badge bg-{}">{}</span>',
            status_class.get(obj.status, 'secondary'),
            status_dict.get(obj.status, obj.status)
        )
    status_display.short_description = 'Trạng thái'
    
    def payment_status_display(self, obj):
        status_dict = dict(self.PAYMENT_STATUS)
        status_class = {
            'pending': 'warning',
            'paid': 'success',
            'refunded': 'info'
        }
        return format_html(
            '<span class="badge bg-{}">{}</span>',
            status_class.get(obj.payment_status, 'secondary'),
            status_dict.get(obj.payment_status, obj.payment_status)
        )
    payment_status_display.short_description = 'Trạng thái thanh toán'

@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'phone', 'address_detail', 'birth_date', 'gender')
    search_fields = ('user__username', 'phone', 'address_detail')
    list_filter = ('gender', 'newsletter')

@admin.register(Cart)
class CartAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', 'item_count', 'total_price', 'created_at']
    list_filter = ['created_at']
    search_fields = ['user__username']
    date_hierarchy = 'created_at'

    def item_count(self, obj):
        return obj.items.count()
    item_count.short_description = 'Số lượng sản phẩm'

    def total_price(self, obj):
        return f"{obj.total_price:,.0f}đ"
    total_price.short_description = 'Tổng tiền'

@admin.register(CartItem)
class CartItemAdmin(admin.ModelAdmin):
    list_display = ['id', 'cart', 'product', 'quantity', 'total_price', 'created_at']
    list_filter = ['created_at']
    search_fields = ['cart__user__username', 'product__name']
    date_hierarchy = 'created_at'
    raw_id_fields = ['cart', 'product']

    def total_price(self, obj):
        return f"{obj.total_price:,.0f}đ"
    total_price.short_description = 'Tổng tiền'

@admin.register(Review)
class ReviewAdmin(admin.ModelAdmin):
    list_display = ['user', 'product', 'rating', 'created_at']
    list_filter = ['rating', 'created_at']
    search_fields = ['user__username', 'product__name', 'comment']
    readonly_fields = ['created_at']
    raw_id_fields = ['user', 'product']
    ordering = ['-created_at']

@admin.register(Wishlist)
class WishlistAdmin(admin.ModelAdmin):
    list_display = ('user', 'product', 'created_at')
    list_filter = ('created_at',)
    search_fields = ('user__username', 'product__name')
    ordering = ('-created_at',)

@admin.register(Coupon)
class CouponAdmin(admin.ModelAdmin):
    list_display = ['code', 'discount_display', 'minimum_amount_display', 'valid_from', 'valid_to', 'active', 'usage_count']
    list_filter = ['active', 'valid_from', 'valid_to']
    search_fields = ['code']
    readonly_fields = ['usage_count']
    
    fieldsets = (
        ('Thông tin cơ bản', {
            'fields': ('code', 'discount', 'minimum_amount', 'active')
        }),
        ('Thời gian hiệu lực', {
            'fields': ('valid_from', 'valid_to')
        }),
        ('Thống kê', {
            'fields': ('usage_count',),
            'classes': ('collapse',)
        }),
    )
    
    def discount_display(self, obj):
        return f'{int(obj.discount):,} đ'
    discount_display.short_description = 'Giảm giá'
    
    def minimum_amount_display(self, obj):
        return f'{int(obj.minimum_amount):,} đ'
    minimum_amount_display.short_description = 'Đơn hàng tối thiểu'
    
    def usage_count(self, obj):
        """Đếm số lần coupon được sử dụng"""
        return obj.order_set.count()
    usage_count.short_description = 'Số lần sử dụng'

# Customize Admin Site
admin.site.site_header = 'Quản Lý Thuốc Thú Y'
admin.site.site_title = 'Quản Lý Thuốc Thú Y'
admin.site.index_title = 'Trang Quản Trị'
