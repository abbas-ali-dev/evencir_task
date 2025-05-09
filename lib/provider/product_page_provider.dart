import 'package:flutter/material.dart';
import 'package:evencir_task/core/api_services/dio_service.dart';
import 'package:evencir_task/core/api_services/end_points.dart';
import 'package:evencir_task/model/product_page_model.dart';
import 'package:evencir_task/widgets/loader/easy_loading.dart';
import 'package:evencir_task/widgets/toaster/toaster.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProductPageProvider extends ChangeNotifier {
  ProductPageModel? _productPageModel;
  bool _isLoading = false;
  String _errorMessage = '';

  ProductPageModel? get productPageModel => _productPageModel;
  List<Product> get products => _productPageModel?.products ?? [];
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  ProductPageProvider();

  Future<void> fetchProducts() async {
    try {
      _isLoading = true;
      notifyListeners();

      await Easyloding.configLoading();
      EasyLoading.show(status: 'Loading products...');

      final response = await NetworkManager().callApi(
        method: HttpMethod.Get,
        urlEndPoint: EndPoints.products,
      );

      if (response != null && response.statusCode == 200) {
        _productPageModel = ProductPageModel.fromJson(response.data);
        _errorMessage = '';
      } else {
        _errorMessage =
            'Failed to load products. Status code: ${response?.statusCode}';
        await Toaster.showToast(_errorMessage);
      }
    } catch (e) {
      _errorMessage = 'Error fetching products: ${e.toString()}';
      await Toaster.showToast(_errorMessage);
    } finally {
      _isLoading = false;
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  void retryFetch() {
    fetchProducts();
  }

  List<Product> searchProducts(String query) {
    if (query.isEmpty) return products;

    return products
        .where((product) =>
            product.title?.toLowerCase().contains(query.toLowerCase()) ?? false)
        .toList();
  }

  List<Product> filterByCategory(String category) {
    if (category.isEmpty) return products;

    return products
        .where((product) =>
            product.category?.toLowerCase() == category.toLowerCase())
        .toList();
  }

  List<Product> sortByPrice(bool ascending) {
    final sortedProducts = List<Product>.from(products);

    sortedProducts.sort((a, b) {
      if (a.price == null || b.price == null) return 0;
      return ascending
          ? a.price!.compareTo(b.price!)
          : b.price!.compareTo(a.price!);
    });

    return sortedProducts;
  }
}
