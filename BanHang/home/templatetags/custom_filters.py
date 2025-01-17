from django import template

register = template.Library()

@register.filter
def discount_percent(old_price, new_price):
    """Tính phần trăm giảm giá"""
    if not old_price or not new_price:
        return 0
    try:
        discount = ((float(old_price) - float(new_price)) / float(old_price)) * 100
        return int(discount)
    except (ValueError, ZeroDivisionError):
        return 0

@register.filter
def avg(queryset, field):
    """Tính trung bình của một field trong queryset"""
    if queryset:
        total = sum(getattr(obj, field) for obj in queryset)
        return total / len(queryset)
    return 0 

@register.filter
def order_status_color(status):
    colors = {
        'pending': 'warning',
        'confirmed': 'info',
        'shipping': 'primary',
        'completed': 'success',
        'cancelled': 'danger'
    }
    return colors.get(status, 'secondary') 