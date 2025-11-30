import 'package:flutter/material.dart';
import '../../domain/entities/feed.dart'; // <- adjust path as needed

class ProductCard extends StatelessWidget {
  final FeedItem product;
  final VoidCallback onTap;
  final double width;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.width = 160,
  });

  Widget _buildImage() {
    final img = product.image;
    final widgetImg = img.startsWith('http')
        ? Image.network(
            img,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (c, child, progress) =>
                progress == null
                    ? child
                    : const SizedBox(
                        height: 160,
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
            errorBuilder: (c, e, s) => const SizedBox(
              height: 160,
              child: Center(
                child: Icon(Icons.broken_image_outlined),
              ),
            ),
          )
        : Image.asset(
            img,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
          );
    return widgetImg;
  }

  @override
  Widget build(BuildContext context) {
    // In our domain entity, price is always set
    final double effectivePrice = product.price;

    // Show old price only if present and bigger than current
    final double? oldPrice = (product.oldPrice != null &&
            product.oldPrice! > effectivePrice)
        ? product.oldPrice
        : null;

    // Discount badge: prefer given % else compute from old/new
    int? discountPercent = product.discount;
    if (discountPercent == null &&
        oldPrice != null &&
        oldPrice > 0 &&
        effectivePrice > 0) {
      discountPercent =
          (((oldPrice - effectivePrice) / oldPrice) * 100).round();
      if (discountPercent <= 0) discountPercent = null;
    }

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _buildImage(),
                ),
                if (discountPercent != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '-$discountPercent%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                if (product.isNew)
                  Positioned(
                    top: 8,
                    left: discountPercent == null ? 8 : 72,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'NEW',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: product.isFavorite
                          ? Colors.redAccent
                          : Colors.grey.shade600,
                      size: 18,
                    ),
                  ),
                ),
              ],
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
              product.name,
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
                  '\$${effectivePrice.toStringAsFixed(0)}',
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
