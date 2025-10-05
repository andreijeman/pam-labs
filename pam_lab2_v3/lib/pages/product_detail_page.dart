import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String _selectedSize = 'M';
  String _selectedColor = 'Black';

  // sample recommendations (network placeholders so app runs without assets)
  late final List<Product> recommendations = List.generate(6, (i) {
    final isNew = i % 3 == 0;
    final discount = i % 4 == 0 ? 20.0 : null;
    return Product(
      title: i % 2 == 0 ? 'Evening Dress' : 'T-Shirt Sailing',
      brand: i % 2 == 0 ? 'Dorothy Perkins' : 'Mango Boy',
      image: 'https://picsum.photos/seed/reco$i/300/400',
      price: i % 2 == 0 ? 12 : 10,
      oldPrice: i % 4 == 0 ? (i % 2 == 0 ? 15 : 12) : null,
      discount: discount,
      isNew: isNew,
    );
  });

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _imageCarousel() {
    // If product.image is a comma-separated list you could split here; using single image for simplicity.
    return SizedBox(
      height: 340,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (idx) => setState(() => _currentPage = idx),
            itemCount: 2,
            itemBuilder: (context, index) {
              final image = index == 0 ? widget.product.image : 'https://picsum.photos/seed/alt${index}/600/800';
              if (image.startsWith('http')) {
                return Image.network(image, fit: BoxFit.cover, width: double.infinity);
              } else {
                return Image.asset(image, fit: BoxFit.cover, width: double.infinity);
              }
            },
          ),
          // top bar icons:
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
          // small page indicator at bottom of image
          Positioned(
            bottom: 8,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                2,
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
    );
  }

  Widget _dropDownSelectors() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.white,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedSize,
                items: ['S', 'M', 'L', 'XL'].map((s) => DropdownMenuItem(value: s, child: Text('Size: $s'))).toList(),
                onChanged: (v) => setState(() => _selectedSize = v ?? _selectedSize),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.white,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: _selectedColor,
                items: ['Black', 'White', 'Red'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (v) => setState(() => _selectedColor = v ?? _selectedColor),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
          ]),
          child: IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _addToCartButton() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            elevation: 6,
          ),
          child: const Text('ADD TO CART', style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 12),
        // Home indicator (iOS-like)
        Container(
          height: 6,
          width: 120,
          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
        ),
      ],
    );
  }

  Widget _infoList() {
    return Column(
      children: [
        const SizedBox(height: 18),
        ListTile(
          title: const Text('Shipping info', style: TextStyle(fontWeight: FontWeight.w500)),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        const Divider(height: 1),
        ListTile(
          title: const Text('Support', style: TextStyle(fontWeight: FontWeight.w500)),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        const Divider(height: 1),
      ],
    );
  }

  Widget _recommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('You can also like this', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text('12 items', style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 260,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            scrollDirection: Axis.horizontal,
            itemCount: recommendations.length,
            itemBuilder: (context, idx) {
              final p = recommendations[idx];
              return ProductCard(
                product: p,
                width: 160,
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => ProductDetailPage(product: p)),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            // Image carousel + top controls
            _imageCarousel(),
            const SizedBox(height: 12),
            // selectors row
            _dropDownSelectors(),
            const SizedBox(height: 16),
            // Brand, title, price & rating
            Text(p.brand, style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 4),
            Text(p.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                if (p.oldPrice != null)
                  Text('\$${p.oldPrice!.toStringAsFixed(0)}',
                      style: const TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough)),
                if (p.oldPrice != null) const SizedBox(width: 8),
                Text('\$${p.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 20, color: Colors.redAccent, fontWeight: FontWeight.bold)),
                const Spacer(),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 6),
                    Text('(10)', style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed hem.',
              style: TextStyle(height: 1.4),
            ),
            const SizedBox(height: 18),
            // Add to cart + home indicator
            _addToCartButton(),
            // Shipping info / Support
            _infoList(),
            // Recommendations
            _recommendations(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
