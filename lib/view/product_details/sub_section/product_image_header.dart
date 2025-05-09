import 'package:cached_network_image/cached_network_image.dart';
import 'package:evencir_task/provider/product_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductImageHeader extends StatelessWidget {
  const ProductImageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductDetailsProvider>(context);
    final product = productData.product;

    return CachedNetworkImage(
      imageUrl: product?.thumbnail ?? '',
      imageBuilder: (context, imageProvider) => Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: 300,
        width: double.infinity,
        color: Colors.grey[300],
        child: const Center(
          child: Text('Image not available'),
        ),
      ),
    );
  }
}
