import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final double width;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.width = 160,
  });

  Widget _buildImage() {
    if (product.image.startsWith('http')) {
      return Image.network(product.image, height: 160, width: double.infinity, fit: BoxFit.cover);
    } else {
      return Image.asset(product.image, height: 160, width: double.infinity, fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _buildImage(),
              ),
              // Discount badge
              if (product.discount != null)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('-${product.discount!.toInt()}%',
                        style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              // NEW badge (if applicable)
              if (product.isNew)
                Positioned(
                  top: 8,
                  left: product.discount == null ? 8 : 72,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('NEW', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              // Favorite circle
              Positioned(
                bottom: 8,
                right: 8,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite_border, color: Colors.grey.shade600, size: 18),
                ),
              ),
            ]),
            const SizedBox(height: 8),
            Text(product.brand, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            const SizedBox(height: 2),
            Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Row(
              children: [
                if (product.oldPrice != null)
                  Text(
                    '\$${product.oldPrice!.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                if (product.oldPrice != null) const SizedBox(width: 6),
                Text('\$${product.price.toStringAsFixed(0)}',
                    style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
