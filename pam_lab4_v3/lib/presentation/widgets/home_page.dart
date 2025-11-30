import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/feed.dart';
import '../../domain/entities/product.dart' as domain;
import '../blocs/feed_bloc.dart';
import '../widgets/product_card.dart';
import '../widgets/section_header.dart';
import 'product_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedInitial || state is FeedLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FeedError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          if (state is! FeedLoaded) {
            return const Center(child: Text('No data found'));
          }

          final Feed feed = state.feed;

          // Flatten all feed items for recommendations
          final List<FeedItem> allFeedItems =
              feed.sections.expand((s) => s.items).toList();

          // Map FeedItem -> RelatedProduct for ProductDetailPage
          domain.RelatedProduct _mapToRelated(FeedItem item) {
            return domain.RelatedProduct(
              id: item.id.toString(),
              title: item.name,
              brand: item.brand,
              price: item.price,
              oldPrice: item.oldPrice,
              currency: 'USD', // static for now, API has USD
              discount: item.discount != null ? '-${item.discount}%' : null,
              rating: item.rating,
              reviewsCount: item.reviews,
              image: item.image,
            );
          }

          final List<domain.RelatedProduct> allRelatedProducts =
              allFeedItems.map(_mapToRelated).toList();

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 260,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(feed.title),
                  background: Image.network(
                    feed.bannerImage,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) =>
                        const Center(child: Icon(Icons.broken_image_outlined)),
                  ),
                ),
              ),

              // Render each section from the feed
              ...feed.sections.map(
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
                              final FeedItem item = section.items[index];
                              final related = _mapToRelated(item);

                              return Padding(
                                padding: EdgeInsets.only(
                                  right:
                                      index == section.items.length - 1 ? 0 : 12,
                                ),
                                child: ProductCard(
                                  product: item,
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProductDetailPage(
                                        product: related,
                                        recommendedProducts:
                                            allRelatedProducts,
                                      ),
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
