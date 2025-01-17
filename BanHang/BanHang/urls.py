"""
URL configuration for BanHang project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path
from home import views as home_views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', home_views.home, name='home'),
    path('login/', home_views.login_view, name='login'),
    path('register/', home_views.register_view, name='register'),
    path('cart/', home_views.cart_view, name='cart'),
    path('products/', home_views.products, name='products'),
    path('product/<int:id>/', home_views.product_detail, name='product_detail'),
    path('product/<int:product_id>/review/', home_views.add_review, name='add_review'),
    path('about/', home_views.about_view, name='about'),
    path('news/', home_views.news_view, name='news'),
    path('contact/', home_views.contact_view, name='contact'),
    path('profile/', home_views.profile_view, name='profile'),
    path('orders/', home_views.orders_view, name='orders'),
    path('logout/', home_views.logout_view, name='logout'),
    path('search/', home_views.search_view, name='search'),
    path('profile/update/', home_views.profile_update, name='profile_update'),
    path('profile/change-password/', home_views.change_password, name='change_password'),
    path('wishlist/remove/<int:id>/', home_views.remove_from_wishlist, name='remove_from_wishlist'),
    path('review/remove/<int:id>/', home_views.remove_review, name='remove_review'),
    path('wishlist/toggle/<int:product_id>/', home_views.toggle_wishlist, name='toggle_wishlist'),
    path('cart/add/<int:product_id>/', home_views.add_to_cart, name='add_to_cart'),
    path('cart/update/<int:item_id>/', home_views.update_cart_item, name='update_cart_item'),
    path('cart/remove/<int:item_id>/', home_views.remove_cart_item, name='remove_cart_item'),
    path('checkout/', home_views.checkout_view, name='checkout'),
    path('cart/apply-coupon/', home_views.apply_coupon, name='apply_coupon'),
    path('checkout/place-order/', home_views.place_order, name='place_order'),
    path('order/<str:order_number>/', home_views.order_detail, name='order_detail'), 
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
