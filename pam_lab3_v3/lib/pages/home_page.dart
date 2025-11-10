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

          // Optional: build a flat list of all products (used for recommendations/navigation)
          final List<Product> allProducts =
              catalog.sections.expand((s) => s.items).toList();

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

              // 🔁 Render every section from JSON
              ...catalog.sections.map(
                (section) => SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(
                          title: section.title,
                          subtitle: section.subtitle,
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 270,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: section.items.length,
                            itemBuilder: (context, index) {
                              final p = section.items[index];
                              return ProductCard(
                                product: p,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProductDetailPage(
                                      product: p,
                                      recommendedProducts: allProducts,
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
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          );
        },
      ),
    );
  }
}
