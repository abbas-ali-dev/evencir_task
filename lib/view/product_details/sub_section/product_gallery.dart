import 'package:cached_network_image/cached_network_image.dart';
import 'package:evencir_task/constants/text_styles.dart';
import 'package:evencir_task/provider/product_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGallery extends StatelessWidget {
  const ProductGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductDetailsProvider>(context);
    final product = productData.product;

    if (product == null || product.images == null || product.images!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Gallery:  ',
            style: AppTextStyles.bodyPoppins
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.0,
              ),
              itemCount: product.images!.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: product.images![index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Text('Image not available'),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
