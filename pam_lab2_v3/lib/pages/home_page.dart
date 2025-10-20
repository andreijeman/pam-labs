import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/section_header.dart';
import 'product_detail_page.dart';

class HomePage extends StatelessWidget {
  final List<Product> _saleProducts;
  final List<Product> _newProducts;
  final List<Product> _recommendedProducts;

  const HomePage({
    super.key,
    required List<Product> saleProducts,
    required List<Product> newProducts,
    required List<Product> recommendedProducts
  }) : _newProducts = newProducts, _saleProducts = saleProducts, _recommendedProducts = recommendedProducts;

  @override
  Widget build(BuildContext context) {  
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
                      itemCount: _saleProducts.length,
                      itemBuilder: (context, index) => ProductCard(
                        product: _saleProducts[index],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(product: _saleProducts[index], recommendedProducts: _recommendedProducts),
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
                      itemCount: _newProducts.length,
                      itemBuilder: (context, index) => ProductCard(
                        product: _newProducts[index],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(product: _newProducts[index], recommendedProducts: _recommendedProducts,),
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
                      itemCount: _saleProducts.length,
                      itemBuilder: (context, index) => ProductCard(
                        product: _saleProducts[(index + 1) % _saleProducts.length],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(product: _saleProducts[(index + 1) % _saleProducts.length], recommendedProducts: _recommendedProducts),
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
