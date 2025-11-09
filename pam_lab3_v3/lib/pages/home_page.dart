import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/product_card.dart';
import '../widgets/section_header.dart';
import '../models/product.dart';
import '../blocs/catalog/catalog_state.dart';
import '../blocs/catalog/catalog_bloc.dart';
import '../pages/product_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CatalogBloc, CatalogState>(
        builder: (context, state) {
          if (state.status == 'loading' || state.status == 'initial') {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == 'failure') {
            return Center(child: Text('Error: ${state.error}'));
          }

          final catalog = state.catalog;
          if (catalog == null) {
            return const Center(child: Text('No data found'));
          }

          final sale = catalog.sections.firstWhere(
            (s) => s.title.toLowerCase() == 'sale',
            orElse: () => catalog.sections.first,
          );
          final news = catalog.sections.firstWhere(
            (s) => s.title.toLowerCase() == 'new',
            orElse: () => catalog.sections.last,
          );

          // Simple “recommended”: all products minus duplicates from "Sale" first item
          final List<Product> recommended = [
            ...sale.items,
            ...news.items,
          ];

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 260,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(catalog.header.title),
                  background: Image.network(
                    catalog.header.bannerImage,
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
                      SectionHeader(title: sale.title, subtitle: sale.subtitle),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 270,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: sale.items.length,
                          itemBuilder: (context, index) => ProductCard(
                            product: sale.items[index],
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailPage(
                                  product: sale.items[index],
                                  recommendedProducts: recommended,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                      SectionHeader(title: news.title, subtitle: news.subtitle),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 270,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: news.items.length,
                          itemBuilder: (context, index) => ProductCard(
                            product: news.items[index],
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailPage(
                                  product: news.items[index],
                                  recommendedProducts: recommended,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                      SectionHeader(title: 'Recommended', subtitle: 'Picked for you'),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 270,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: recommended.length,
                          itemBuilder: (context, index) {
                            final p = recommended[index];
                            return ProductCard(
                              product: p,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailPage(
                                    product: p,
                                    recommendedProducts: recommended,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
