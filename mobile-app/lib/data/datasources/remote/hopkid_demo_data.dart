import '../../../domain/entities/category.dart';
import '../../../domain/entities/coupon.dart';
import '../../../domain/entities/order_entity.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/user_profile.dart';

class HopkidDemoData {
  HopkidDemoData._();

  static const List<Category> categories = [
    Category(
      id: 'boys',
      name: 'Boys Collection',
      iconName: 'boy',
      bgColorHex: 0xFFE8F2FF,
      isShortcut: true,
    ),
    Category(
      id: 'girls',
      name: 'Girls Collection',
      iconName: 'girl',
      bgColorHex: 0xFFFCE7F3,
      isShortcut: true,
    ),
    Category(
      id: 'baby',
      name: 'Baby & Newborn',
      iconName: 'baby',
      bgColorHex: 0xFFF4EAFE,
      isShortcut: true,
    ),
    Category(
      id: 'toys',
      name: 'Toys & Games',
      iconName: 'toys',
      bgColorHex: 0xFFFFF3DF,
      isShortcut: true,
    ),
    Category(
      id: 'ethnic',
      name: 'Ethnic Wear',
      iconName: 'ethnic',
      bgColorHex: 0xFFEDE0FA,
    ),
    Category(
      id: 'accessories',
      name: 'Accessories',
      iconName: 'accessories',
      bgColorHex: 0xFFE7F8EA,
    ),
    Category(
      id: 'footwear',
      name: 'Footwear',
      iconName: 'footwear',
      bgColorHex: 0xFFE8F2FF,
    ),
    Category(
      id: 'gear',
      name: 'Baby Gear',
      iconName: 'gear',
      bgColorHex: 0xFFFCE7F3,
    ),
  ];

  static const List<Product> products = [
    Product(
      id: 'p1',
      name: 'Dino Print T-Shirt (Boys)',
      categoryId: 'boys',
      subCategory: 'T-Shirts',
      price: 419,
      originalPrice: 599,
      discountLabel: '30% OFF',
      rating: 4.8,
      reviewCount: 142,
      images: [
        'assets/images/products/dino_tshirt.jpg',
        'assets/images/products/purple_hoodie.jpg',
      ],
      sizes: ['1–2 Y', '3–4 Y', '5–6 Y', '7–8 Y'],
      description:
          'Ultra-soft 100% combed cotton t-shirt with a playful dinosaur graphic print. Gentle on sensitive skin and breathable for all-day play.',
      stockCount: 28,
    ),
    Product(
      id: 'p2',
      name: 'Hoodie Sweatshirt (Purple)',
      categoryId: 'boys',
      subCategory: 'Jackets',
      price: 799,
      originalPrice: 1199,
      discountLabel: '33% OFF',
      rating: 4.9,
      reviewCount: 98,
      images: [
        'assets/images/products/purple_hoodie.jpg',
        'assets/images/products/dino_tshirt.jpg',
      ],
      sizes: ['1–2 Y', '3–4 Y', '5–6 Y', '7–8 Y'],
      description:
          'Cozy fleece-lined purple hoodie sweatshirt with embroidered cloud emblem and ribbed cuffs for chilly evenings.',
      stockCount: 18,
    ),
    Product(
      id: 'p3',
      name: 'Girls Frill Party Dress',
      categoryId: 'girls',
      subCategory: 'Dresses',
      price: 899,
      originalPrice: 1299,
      discountLabel: '31% OFF',
      rating: 4.7,
      reviewCount: 116,
      images: [
        'assets/images/products/frill_dress.jpg',
        'assets/images/banners/offers_banner.jpg',
      ],
      sizes: ['1–2 Y', '3–4 Y', '5–6 Y', '7–8 Y'],
      description:
          'Pastel blush-pink layered tulle frill dress with a satin waist bow and soft cotton lining for effortless comfort.',
      stockCount: 22,
    ),
    Product(
      id: 'p4',
      name: 'Denim Jacket Classic',
      categoryId: 'boys',
      subCategory: 'Jackets',
      price: 1049,
      originalPrice: 1499,
      discountLabel: '30% OFF',
      rating: 4.6,
      reviewCount: 64,
      images: [
        'assets/images/products/purple_hoodie.jpg',
        'assets/images/products/dino_tshirt.jpg',
      ],
      sizes: ['1–2 Y', '3–4 Y', '5–6 Y', '7–8 Y'],
      description:
          'Stretchable washed denim jacket tailored for active kids with easy snap buttons and roomy pockets.',
      stockCount: 15,
    ),
    Product(
      id: 'p5',
      name: 'Striped Casual Shirt',
      categoryId: 'boys',
      subCategory: 'Shirts',
      price: 549,
      originalPrice: 799,
      discountLabel: '31% OFF',
      rating: 4.5,
      reviewCount: 51,
      images: [
        'assets/images/products/dino_tshirt.jpg',
      ],
      sizes: ['1–2 Y', '3–4 Y', '5–6 Y', '7–8 Y'],
      description:
          'Smart-casual cotton poplin shirt with breathable weave, perfect for birthdays and weekend outings.',
      stockCount: 20,
    ),
    Product(
      id: 'p6',
      name: 'Comfort Fit Stretch Jeans',
      categoryId: 'boys',
      subCategory: 'Jeans',
      price: 699,
      originalPrice: 999,
      discountLabel: '30% OFF',
      rating: 4.7,
      reviewCount: 83,
      images: [
        'assets/images/products/purple_hoodie.jpg',
      ],
      sizes: ['1–2 Y', '3–4 Y', '5–6 Y', '7–8 Y'],
      description:
          'Soft-waistband stretch denim jeans designed for easy movement and playful comfort.',
      stockCount: 30,
    ),
  ];

  static const List<Coupon> coupons = [
    Coupon(
      code: 'WELCOME10',
      title: 'Welcome Offer',
      description: 'Get 10% OFF on your first order',
      discountPercent: 10,
      maxDiscount: 300,
      minOrderAmount: 499,
      expiryDate: 'Valid till Dec 31, 2026',
    ),
    Coupon(
      code: 'HOPKID20',
      title: 'Festive Mega Deal',
      description: 'Flat 20% OFF on orders above ₹1,999',
      discountPercent: 20,
      maxDiscount: 600,
      minOrderAmount: 1999,
      expiryDate: 'Valid till Dec 15, 2026',
    ),
    Coupon(
      code: 'FASHION30',
      title: 'Kids Fashion Special',
      description: 'Get 30% OFF on selected styles',
      discountPercent: 30,
      maxDiscount: 800,
      minOrderAmount: 1299,
      expiryDate: 'Valid till Nov 30, 2026',
    ),
  ];

  static final List<OrderEntity> initialOrders = [
    OrderEntity(
      id: '#HPK2469',
      productName: 'Dino Print T-Shirt (Boys)',
      productImage: 'assets/images/products/dino_tshirt.jpg',
      price: 419,
      quantity: 2,
      status: OrderStatus.shipped,
      orderDate: 'Nov 24, 2026',
      trackingSteps: const [
        TrackingStep(
          title: 'Order Placed',
          date: 'Nov 24, 2026',
          time: '10:15 AM',
          isCompleted: true,
          isCurrent: false,
        ),
        TrackingStep(
          title: 'Processing',
          date: 'Nov 24, 2026',
          time: '02:30 PM',
          isCompleted: true,
          isCurrent: false,
        ),
        TrackingStep(
          title: 'Shipped',
          date: 'Nov 25, 2026',
          time: '09:45 AM',
          isCompleted: true,
          isCurrent: true,
        ),
        TrackingStep(
          title: 'Out for Delivery',
          date: 'Expected Nov 27',
          time: '--',
          isCompleted: false,
          isCurrent: false,
        ),
        TrackingStep(
          title: 'Delivered',
          date: 'Expected Nov 27',
          time: '--',
          isCompleted: false,
          isCurrent: false,
        ),
      ],
    ),
    OrderEntity(
      id: '#HPK2418',
      productName: 'Girls Frill Party Dress',
      productImage: 'assets/images/products/frill_dress.jpg',
      price: 899,
      quantity: 1,
      status: OrderStatus.delivered,
      orderDate: 'Nov 19, 2026',
      trackingSteps: const [
        TrackingStep(
          title: 'Order Placed',
          date: 'Nov 19, 2026',
          time: '11:00 AM',
          isCompleted: true,
          isCurrent: false,
        ),
        TrackingStep(
          title: 'Processing',
          date: 'Nov 19, 2026',
          time: '03:20 PM',
          isCompleted: true,
          isCurrent: false,
        ),
        TrackingStep(
          title: 'Shipped',
          date: 'Nov 20, 2026',
          time: '08:15 AM',
          isCompleted: true,
          isCurrent: false,
        ),
        TrackingStep(
          title: 'Out for Delivery',
          date: 'Nov 21, 2026',
          time: '09:30 AM',
          isCompleted: true,
          isCurrent: false,
        ),
        TrackingStep(
          title: 'Delivered',
          date: 'Nov 21, 2026',
          time: '01:45 PM',
          isCompleted: true,
          isCurrent: true,
        ),
      ],
    ),
    OrderEntity(
      id: '#HPK2402',
      productName: 'Hoodie Sweatshirt (Purple)',
      productImage: 'assets/images/products/purple_hoodie.jpg',
      price: 799,
      quantity: 1,
      status: OrderStatus.processing,
      orderDate: 'Nov 26, 2026',
      trackingSteps: const [
        TrackingStep(
          title: 'Order Placed',
          date: 'Nov 26, 2026',
          time: '09:10 AM',
          isCompleted: true,
          isCurrent: false,
        ),
        TrackingStep(
          title: 'Processing',
          date: 'Nov 26, 2026',
          time: '11:40 AM',
          isCompleted: true,
          isCurrent: true,
        ),
        TrackingStep(
          title: 'Shipped',
          date: 'Pending',
          time: '--',
          isCompleted: false,
          isCurrent: false,
        ),
        TrackingStep(
          title: 'Out for Delivery',
          date: 'Pending',
          time: '--',
          isCompleted: false,
          isCurrent: false,
        ),
        TrackingStep(
          title: 'Delivered',
          date: 'Pending',
          time: '--',
          isCompleted: false,
          isCurrent: false,
        ),
      ],
    ),
  ];

  static const UserProfile defaultProfile = UserProfile(
    id: 'u1',
    name: 'Priya Sharma',
    email: 'priya.sharma@hopkid.in',
    phone: '+91 98765 43210',
    addresses: [
      AddressEntity(
        id: 'addr-1',
        title: 'Home',
        fullAddress: 'Flat 402, Blossom Heights, Baner Road, Pune - 411045',
        phone: '+91 98765 43210',
        isDefault: true,
      ),
      AddressEntity(
        id: 'addr-2',
        title: 'Grandparents Home',
        fullAddress: '14, Rose Villa, Koregaon Park, Pune - 411001',
        phone: '+91 98220 11223',
      ),
    ],
  );
}
