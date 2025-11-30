import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/product.dart' as domain;
import '../../domain/usecases/get_product_details.dart';
import '../../data/datasources/product_details_remote_data_source.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../blocs/product_details_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  /// Summary product (e.g. from feed/related list)
  final domain.RelatedProduct product;
  final List<domain.RelatedProduct> recommendedProducts;

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

  int _colorIndex = 0;
  int _sizeIndex = 0;
  bool _wishlisted = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Local wiring of HTTP + data source + repo + usecase + bloc
    return BlocProvider<ProductDetailsBloc>(
      create: (_) {
        final client = http.Client();
        final remote = ProductDetailsRemoteDataSourceImpl(client: client);
        final repo = ProductRepositoryImpl(remoteDataSource: remote);
        final usecase = GetProductDetails(repo);

        return ProductDetailsBloc(usecase)
          ..add(LoadProductDetails(productId: widget.product.id));
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
            builder: (context, state) {
              if (state is ProductDetailsInitial ||
                  state is ProductDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ProductDetailsError) {
                return Center(
                  child: Text(
                    'Error: ${state.message}',
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (state is! ProductDetailsLoaded) {
                return const Center(child: Text('No product details'));
              }

              final data = state.product; // domain.Product

              // Clamp indices
              if (_colorIndex >= data.colors.length) _colorIndex = 0;
              if (_sizeIndex >= data.sizes.length) _sizeIndex = 0;

              final color = data.colors[_colorIndex];
              final double effectivePrice = data.price;
              final double? oldPrice = widget.product.oldPrice;

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
                          },
                          itemCount: color.images.length,
                          itemBuilder: (context, index) => Image.network(
                            color.images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (c, e, s) =>
                                const Center(child: Icon(Icons.broken_image_outlined)),
                            loadingBuilder: (c, child, progress) =>
                                progress == null
                                    ? child
                                    : const Center(child: CircularProgressIndicator()),
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
                              onPressed: () {
                                // TODO: implement share
                              },
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                width: _currentPage == i ? 28 : 12,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: _currentPage == i
                                      ? Colors.black87
                                      : Colors.black26,
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
                          value: _colorIndex,
                          decoration: _ddDecoration().copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                          ),
                          items: List.generate(
                            data.colors.length,
                            (i) => DropdownMenuItem(
                              value: i,
                              child: Text(
                                data.colors[i].name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          onChanged: (i) {
                            if (i == null) return;
                            setState(() {
                              _colorIndex = i;
                              _currentPage = 0;
                              _pageController.jumpToPage(0);
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          isExpanded: true,
                          value: _sizeIndex,
                          decoration: _ddDecoration().copyWith(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                          ),
                          items: List.generate(
                            data.sizes.length,
                            (i) => DropdownMenuItem(
                              value: i,
                              child: Text(
                                data.sizes[i],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          onChanged: (i) {
                            if (i == null) return;
                            setState(() => _sizeIndex = i);
                          },
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
                            icon: Icon(
                              _wishlisted
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() => _wishlisted = !_wishlisted);
                            },
                            padding: EdgeInsets.zero,
                            iconSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Brand, title, price & rating
                  Text(
                    widget.product.brand,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (oldPrice != null)
                        Text(
                          '\$${oldPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      if (oldPrice != null) const SizedBox(width: 8),
                      Text(
                        '\$${effectivePrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${data.rating} (${data.reviewsCount})',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Text(
                    data.description,
                    style: const TextStyle(height: 1.4),
                  ),
                  const SizedBox(height: 18),

                  // Add to cart
                  ElevatedButton(
                    onPressed: () {
                      // TODO: add to cart using data.id, selected color/size, etc.
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      elevation: 6,
                    ),
                    child: const Text(
                      'ADD TO CART',
                      style: TextStyle(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
      );

  Widget _recommendations(List<domain.RelatedProduct> recos) {
    if (recos.isEmpty) return const SizedBox.shrink();
    final countLabel = '${recos.length} item${recos.length == 1 ? '' : 's'}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 2.0),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'You can also like this',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                countLabel,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
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
              return Padding(
                padding: EdgeInsets.only(
                  right: idx == recos.length - 1 ? 0 : 12,
                ),
                child: _RelatedProductCard(
                  product: p,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(
                          product: p,
                          recommendedProducts: recos,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RelatedProductCard extends StatelessWidget {
  final domain.RelatedProduct product;
  final VoidCallback onTap;

  const _RelatedProductCard({
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final price = product.price;
    final oldPrice = product.oldPrice;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 👇 This part changed
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) =>
                      const Center(child: Icon(Icons.broken_image_outlined)),
                  loadingBuilder: (c, child, progress) =>
                      progress == null
                          ? child
                          : const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.brand,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                if (oldPrice != null)
                  Text(
                    '\$${oldPrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                if (oldPrice != null) const SizedBox(width: 6),
                Text(
                  '\$${price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
