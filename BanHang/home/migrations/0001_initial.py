# Generated by Django 5.0.2 on 2025-01-16 23:16

import django.core.validators
import django.db.models.deletion
import django.utils.timezone
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100, verbose_name='Tên danh mục')),
                ('description', models.TextField(blank=True, verbose_name='Mô tả')),
                ('image', models.ImageField(blank=True, null=True, upload_to='categories/', verbose_name='Hình ảnh')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('slug', models.SlugField(max_length=100, unique=True)),
                ('is_active', models.BooleanField(default=True, verbose_name='Hiển thị')),
            ],
            options={
                'verbose_name': 'Danh mục',
                'verbose_name_plural': 'Danh mục',
                'ordering': ['name'],
            },
        ),
        migrations.CreateModel(
            name='Coupon',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('code', models.CharField(max_length=50, unique=True, verbose_name='Mã giảm giá')),
                ('discount', models.DecimalField(decimal_places=2, max_digits=10, verbose_name='Giá trị giảm')),
                ('valid_from', models.DateTimeField(verbose_name='Có hiệu lực từ')),
                ('valid_to', models.DateTimeField(verbose_name='Có hiệu lực đến')),
                ('active', models.BooleanField(default=True, verbose_name='Còn hiệu lực')),
                ('minimum_amount', models.DecimalField(decimal_places=2, default=0, max_digits=10, verbose_name='Giá trị đơn hàng tối thiểu')),
                ('usage_limit', models.IntegerField(default=0, verbose_name='Giới hạn sử dụng')),
            ],
            options={
                'verbose_name': 'Mã giảm giá',
                'verbose_name_plural': 'Mã giảm giá',
            },
        ),
        migrations.CreateModel(
            name='Cart',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Order',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('order_number', models.CharField(max_length=20, unique=True)),
                ('full_name', models.CharField(max_length=100)),
                ('phone', models.CharField(max_length=20)),
                ('address', models.TextField()),
                ('province_code', models.CharField(max_length=10)),
                ('district_code', models.CharField(max_length=10)),
                ('ward_code', models.CharField(max_length=10)),
                ('payment_method', models.CharField(choices=[('cod', 'Thanh toán khi nhận hàng'), ('bank', 'Chuyển khoản ngân hàng'), ('momo', 'Ví MoMo')], max_length=20)),
                ('note', models.TextField(blank=True)),
                ('subtotal', models.DecimalField(decimal_places=2, max_digits=10)),
                ('discount', models.DecimalField(decimal_places=2, default=0, max_digits=10)),
                ('total_amount', models.DecimalField(decimal_places=2, max_digits=10)),
                ('status', models.CharField(choices=[('pending', 'Chờ xử lý'), ('confirmed', 'Đã xác nhận'), ('shipping', 'Đang giao hàng'), ('completed', 'Đã giao hàng'), ('cancelled', 'Đã hủy')], default='pending', max_length=20)),
                ('payment_status', models.CharField(choices=[('pending', 'Chờ thanh toán'), ('paid', 'Đã thanh toán'), ('refunded', 'Đã hoàn tiền')], default='pending', max_length=20)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('coupon', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='home.coupon')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['-created_at'],
            },
        ),
        migrations.CreateModel(
            name='Product',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200, verbose_name='Tên sản phẩm')),
                ('slug', models.SlugField(max_length=200, unique=True)),
                ('description', models.TextField(verbose_name='Mô tả')),
                ('price', models.DecimalField(decimal_places=2, max_digits=10, verbose_name='Giá')),
                ('old_price', models.DecimalField(blank=True, decimal_places=2, max_digits=10, null=True)),
                ('image', models.ImageField(upload_to='products/', verbose_name='Hình ảnh')),
                ('stock', models.IntegerField(default=0, verbose_name='Số lượng')),
                ('is_available', models.BooleanField(default=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('featured', models.BooleanField(default=False, verbose_name='Sản phẩm nổi bật')),
                ('views', models.IntegerField(default=0, verbose_name='Lượt xem')),
                ('sold', models.IntegerField(default=0, verbose_name='Đã bán')),
                ('specifications', models.JSONField(blank=True, null=True, verbose_name='Thông số kỹ thuật')),
                ('category', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.category', verbose_name='Danh mục')),
            ],
            options={
                'verbose_name': 'Sản phẩm',
                'verbose_name_plural': 'Sản phẩm',
                'ordering': ['-created_at'],
            },
        ),
        migrations.CreateModel(
            name='OrderItem',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantity', models.PositiveIntegerField()),
                ('price', models.DecimalField(decimal_places=2, max_digits=10)),
                ('order', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='items', to='home.order')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.product')),
            ],
        ),
        migrations.CreateModel(
            name='ProductImage',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(upload_to='products/', verbose_name='Hình ảnh')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='images', to='home.product')),
            ],
            options={
                'verbose_name': 'Hình ảnh sản phẩm',
                'verbose_name_plural': 'Hình ảnh sản phẩm',
            },
        ),
        migrations.CreateModel(
            name='Review',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('rating', models.IntegerField(validators=[django.core.validators.MinValueValidator(1), django.core.validators.MaxValueValidator(5)])),
                ('comment', models.TextField()),
                ('images', models.ImageField(blank=True, null=True, upload_to='reviews/')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='reviews', to='home.product')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['-created_at'],
            },
        ),
        migrations.CreateModel(
            name='UserProfile',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('phone', models.CharField(blank=True, max_length=15, null=True)),
                ('address_detail', models.CharField(blank=True, max_length=255, null=True)),
                ('province_code', models.CharField(blank=True, max_length=10, null=True)),
                ('district_code', models.CharField(blank=True, max_length=10, null=True)),
                ('ward_code', models.CharField(blank=True, max_length=10, null=True)),
                ('avatar', models.ImageField(blank=True, null=True, upload_to='avatars/', verbose_name='Ảnh đại diện')),
                ('birth_date', models.DateField(blank=True, null=True, verbose_name='Ngày sinh')),
                ('gender', models.CharField(blank=True, choices=[('M', 'Nam'), ('F', 'Nữ'), ('O', 'Khác')], max_length=1, null=True, verbose_name='Giới tính')),
                ('newsletter', models.BooleanField(default=False, verbose_name='Nhận thông báo')),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'Hồ sơ người dùng',
                'verbose_name_plural': 'Hồ sơ người dùng',
            },
        ),
        migrations.CreateModel(
            name='CartItem',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantity', models.PositiveIntegerField(default=1)),
                ('created_at', models.DateTimeField(default=django.utils.timezone.now)),
                ('updated_at', models.DateTimeField(default=django.utils.timezone.now)),
                ('cart', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='items', to='home.cart')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.product')),
            ],
            options={
                'unique_together': {('cart', 'product')},
            },
        ),
        migrations.CreateModel(
            name='Wishlist',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='home.product')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'verbose_name': 'Danh sách yêu thích',
                'verbose_name_plural': 'Danh sách yêu thích',
                'unique_together': {('user', 'product')},
            },
        ),
    ]