import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/section_header.dart';
import 'product_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Picsum URLs used so images always load without local assets
    final saleProducts = [
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

    final newProducts = [
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

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Street clothes'),
              background: Image.network(
                'https://picsum.photos/seed/header/1200/800',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader(title: 'Sale', subtitle: 'Super summer sale'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 270,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: saleProducts.length,
                      itemBuilder: (context, index) => ProductCard(
                        product: saleProducts[index],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(product: saleProducts[index]),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  SectionHeader(title: 'New', subtitle: 'You’ve never seen it before!'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 270,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: newProducts.length,
                      itemBuilder: (context, index) => ProductCard(
                        product: newProducts[index],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(product: newProducts[index]),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  // optional extra section for variety
                  SectionHeader(title: 'Recommended', subtitle: 'Picked for you'),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 270,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: saleProducts.length,
                      itemBuilder: (context, index) => ProductCard(
                        product: saleProducts[(index + 1) % saleProducts.length],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(product: saleProducts[(index + 1) % saleProducts.length]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
