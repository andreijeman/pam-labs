import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/product.dart';
import '../widgets/product_card.dart';

// Details BLoC + repo that loads assets/details.json
import '../blocs/details/details_bloc.dart';
import '../blocs/details/details_event.dart';
import '../blocs/details/details_state.dart';
import '../repositories/details_repository.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final List<Product> recommendedProducts;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.recommendedProducts,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Provide DetailsBloc here so it loads details.json just for this screen
    return BlocProvider(
      create: (_) => DetailsBloc(DetailsRepository('assets/details.json'))
        ..add(const DetailsEvent.start()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<DetailsBloc, DetailsState>(
            builder: (context, s) {
              if (s.status == 'initial' || s.status == 'loading') {
                return const Center(child: CircularProgressIndicator());
              }

              // Show error if load failed
              if (s.status == 'failure') {
                return Center(child: Text('Error: ${s.error ?? 'Failed to load details'}'));
              }

              // Extra safety: if for any reason data is still null
              final data = s.data;
              if (data == null) {
                return const Center(child: Text('No product details'));
              }

              // ✅ Safe to use `data` now
              final color = data.product.colors[s.colorIndex];

              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // IMAGE CAROUSEL
                  SizedBox(
                    height: 340,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          onPageChanged: (idx) {
                            setState(() => _currentPage = idx);
                            context.read<DetailsBloc>().add(DetailsEvent.selectImage(idx));
                          },
                          itemCount: color.images.length,
                          itemBuilder: (context, index) => Image.network(
                            color.images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 6,
                          left: 8,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.arrow_back, size: 20),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 6,
                          right: 8,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.share, size: 20),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 16,
                          right: 16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              color.images.length,
                              (i) => AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: _currentPage == i ? 28 : 12,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: _currentPage == i ? Colors.black87 : Colors.black26,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // COLOR & SIZE SELECTORS
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          isExpanded: true,
                          initialValue: s.colorIndex,
                          decoration: _ddDecoration().copyWith(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          ),
                          items: List.generate(
                            data.product.colors.length,
                            (i) => DropdownMenuItem(
                              value: i,
                              child: Text(
                                data.product.colors[i].name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          onChanged: (i) => context.read<DetailsBloc>().add(DetailsEvent.selectColor(i ?? 0)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          isExpanded: true,
                          initialValue: s.sizeIndex,
                          decoration: _ddDecoration().copyWith(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          ),
                          items: List.generate(
                            data.product.sizes.length,
                            (i) => DropdownMenuItem(
                              value: i,
                              child: Text(
                                data.product.sizes[i],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          onChanged: (i) => context.read<DetailsBloc>().add(DetailsEvent.selectSize(i ?? 0)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 44,
                        height: 44,
                        child: Material(
                          color: Colors.white,
                          shape: const CircleBorder(),
                          elevation: 1,
                          child: IconButton(
                            icon: Icon(s.wishlisted ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                            onPressed: () => context.read<DetailsBloc>().add(const DetailsEvent.toggleWishlist()),
                            padding: EdgeInsets.zero,
                            iconSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),


                  const SizedBox(height: 16),

                  // Brand, title, price & rating
                  Text(widget.product.brand, style: TextStyle(color: Colors.grey.shade600)),
                  const SizedBox(height: 4),
                  Text(data.product.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (widget.product.oldPrice != null)
                        Text(
                          '\$${widget.product.oldPrice!.toStringAsFixed(0)}',
                          style: const TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough),
                        ),
                      if (widget.product.oldPrice != null) const SizedBox(width: 8),
                      Text(
                        '\$${(widget.product.price ?? widget.product.newPrice ?? 0).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 6),
                          Text('${data.product.rating} (${data.product.reviewsCount})',
                              style: TextStyle(color: Colors.grey.shade600)),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Text(data.product.description, style: const TextStyle(height: 1.4)),
                  const SizedBox(height: 18),

                  // Add to cart
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                      elevation: 6,
                    ),
                    child: const Text('ADD TO CART',
                        style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.w600)),
                  ),

                  const SizedBox(height: 16),

                  // Recommendations
                  _recommendations(widget.recommendedProducts),
                  const SizedBox(height: 24),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  InputDecoration _ddDecoration() => InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      );

  Widget _recommendations(List<Product> recos) {
    if (recos.isEmpty) return const SizedBox.shrink();
    final countLabel = '${recos.length} item${recos.length == 1 ? '' : 's'}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('You can also like this', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(countLabel, style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 260,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recos.length,
            itemBuilder: (context, idx) {
              final p = recos[idx];
              return ProductCard(
                product: p,
                width: 160,
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailPage(product: p, recommendedProducts: recos),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
