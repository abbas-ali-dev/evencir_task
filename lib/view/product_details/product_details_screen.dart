import 'package:evencir_task/constants/text_styles.dart';
import 'package:evencir_task/model/product_page_model.dart';
import 'package:evencir_task/provider/product_details_provider.dart';
import 'package:evencir_task/view/product_details/sub_section/product_detail_section.dart';
import 'package:evencir_task/view/product_details/sub_section/product_gallery.dart';
import 'package:evencir_task/view/product_details/sub_section/product_image_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final provider = ProductDetailsProvider(context);
        provider.setProduct(product);
        return provider;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: Text(
                    'Product Details',
                    style: AppTextStyles.headingPlayfair.copyWith(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProductImageHeader(),
              const ProductDetailsSection(),
              const ProductGallery(),
            ],
          ),
        ),
      ),
    );
  }
}
