import 'package:cached_network_image/cached_network_image.dart';
import 'package:evencir_task/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CustomProductCards extends StatelessWidget {
  const CustomProductCards({
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
      elevation: 2,
      color: Colors.white,
      margin: const EdgeInsets.all(15.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.fill,
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                color: Colors.black,
              )),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyPoppins.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                Text('\$$price   ',
                    style: AppTextStyles.bodyPoppins.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
            const SizedBox(height: 3.0),
            Row(
              children: [
                Text(
                  '$rating',
                  style: AppTextStyles.bodyPoppins.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 5.0),
                const Icon(Icons.star, size: 14, color: Colors.amber),
                const Icon(Icons.star, size: 14, color: Colors.amber),
                const Icon(Icons.star, size: 14, color: Colors.amber),
                const Icon(Icons.star, size: 14, color: Colors.amber),
                const Icon(Icons.star, size: 14, color: Colors.amber),
              ],
            ),
            const SizedBox(height: 5.0),
            Text(
              'By $company',
              style: AppTextStyles.bodyPoppins.copyWith(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              'In $category',
              style: AppTextStyles.bodyPoppins.copyWith(fontSize: 12),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
