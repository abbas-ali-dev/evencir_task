import 'package:flutter/material.dart';

class ProductPageScreen extends StatelessWidget {
  const ProductPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ProductCard(
          imageUrl:
              'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
          title: 'Iphone 14',
          rating: 4.9,
          company: 'Apple',
          category: 'smartphones',
          price: 60,
        ),
        ProductCard(
          imageUrl:
              'https://www.gstatic.com/flutter-onestack-prototype/genui/example_1.jpg',
          title: 'Samsung Galaxy Book',
          rating: 4.9,
          company: 'Samsung',
          category: 'laptops',
          price: 60,
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.company,
    required this.category,
    required this.price,
  });

  final String imageUrl;
  final String title;
  final double rating;
  final String company;
  final String category;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text('$rating'),
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const Icon(Icons.star, size: 16, color: Colors.amber),
                const Icon(Icons.star, size: 16, color: Colors.amber),
              ],
            ),
            Text('By $company'),
            Text('In $category'),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$$price',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
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
