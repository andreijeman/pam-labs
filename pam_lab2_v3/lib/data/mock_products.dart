import '../models/product.dart';

const List<Product> saleProductsMock = [
  Product(
    title: 'Evening Dress',
    brand: 'Dorothy Perkins',
    image: 'https://picsum.photos/seed/dress1/400/600',
    price: 12,
    oldPrice: 15,
    discount: 20,
  ),
  Product(
    title: 'Sport Dress',
    brand: 'Sitlly',
    image: 'https://picsum.photos/seed/dress2/400/600',
    price: 19,
    oldPrice: 22,
    discount: 15,
  ),
  Product(
    title: 'Leather Jacket',
    brand: 'Zara',
    image: 'https://picsum.photos/seed/jacket1/400/600',
    price: 55,
    oldPrice: 70,
    discount: 21,
  ),
  Product(
    title: 'Summer Skirt',
    brand: 'H&M',
    image: 'https://picsum.photos/seed/skirt1/400/600',
    price: 17,
    oldPrice: 21,
    discount: 10,
  ),
  Product(
    title: 'Casual Blouse',
    brand: 'Reserved',
    image: 'https://picsum.photos/seed/blouse1/400/600',
    price: 22,
    oldPrice: 0,
  ),
];

const List<Product> newProductsMock = [
  Product(
    title: 'Red Dress',
    brand: 'Mango',
    image: 'https://picsum.photos/seed/new1/400/600',
    price: 20,
    isNew: true,
  ),
  Product(
    title: 'White T-Shirt',
    brand: 'Mango Boy',
    image: 'https://picsum.photos/seed/new2/400/600',
    price: 10,
    isNew: true,
  ),
  Product(
    title: 'Casual Hoodie',
    brand: 'Uniqlo',
    image: 'https://picsum.photos/seed/hoodie1/400/600',
    price: 25,
    isNew: true,
  ),
  Product(
    title: 'Jeans Jacket',
    brand: 'Levi\'s',
    image: 'https://picsum.photos/seed/jeans1/400/600',
    price: 35,
    isNew: true,
  ),
  Product(
    title: 'Striped Blouse',
    brand: 'Reserved',
    image: 'https://picsum.photos/seed/striped1/400/600',
    price: 22,
    isNew: true,
  ),
  Product(
    title: 'Boho Dress',
    brand: 'Zara',
    image: 'https://picsum.photos/seed/boho1/400/600',
    price: 28,
    isNew: true,
  ),
];

const List<Product> recommendedProducts = [
  Product(
    title: 'Evening Dress',
    brand: 'Dorothy Perkins',
    image: 'https://picsum.photos/seed/reco1/300/400',
    price: 12,
    oldPrice: 15,
    discount: 20,
    isNew: true,
  ),
  Product(
    title: 'T-Shirt Sailing',
    brand: 'Mango Boy',
    image: 'https://picsum.photos/seed/reco2/300/400',
    price: 10,
    oldPrice: 12,
    discount: 15,
    isNew: false,
  ),
  Product(
    title: 'Slim Jeans',
    brand: 'Levi’s',
    image: 'https://picsum.photos/seed/reco3/300/400',
    price: 25,
    oldPrice: 30,
    discount: 10,
    isNew: true,
  ),
];

