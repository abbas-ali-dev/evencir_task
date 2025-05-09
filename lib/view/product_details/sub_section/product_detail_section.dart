import 'package:evencir_task/constants/text_styles.dart';
import 'package:evencir_task/provider/product_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsSection extends StatelessWidget {
  const ProductDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductDetailsProvider>(context);
    final product = productData.product;

    if (product == null) {
      return const Center(child: Text('Product details not available'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Product Details:',
                style: AppTextStyles.bodyPoppins
                    .copyWith(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              IconButton(
                icon: Icon(
                  productData.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: productData.isFavorite ? Colors.red : null,
                ),
                onPressed: () {
                  productData.toggleFavorite();
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Name:   ',
                  style: AppTextStyles.bodyPoppins
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: '${product.title}',
                  style: AppTextStyles.bodyPoppins,
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Price:   ',
                  style: AppTextStyles.bodyPoppins
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: '\$${product.price?.toStringAsFixed(2)}',
                  style: AppTextStyles.littelBodyPoppins,
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Category:   ',
                  style: AppTextStyles.bodyPoppins
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: '${product.category}',
                  style: AppTextStyles.littelBodyPoppins,
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Brand:   ',
                  style: AppTextStyles.bodyPoppins
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: '${product.brand}',
                  style: AppTextStyles.littelBodyPoppins,
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Text(
                'Rating:   ',
                style: AppTextStyles.bodyPoppins
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                '${product.rating}',
                style: AppTextStyles.littelBodyPoppins,
              ),
              const SizedBox(width: 5),
              ...List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Stock:   ',
                  style: AppTextStyles.bodyPoppins
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: '${product.stock}',
                  style: AppTextStyles.littelBodyPoppins,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Description:',
            style:
                AppTextStyles.bodyPoppins.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(
            product.description ?? 'No description available',
            style: AppTextStyles.littelBodyPoppins,
          ),
        ],
      ),
    );
  }
}
