import 'package:flutter/material.dart';
import 'package:evencir_task/core/api_services/dio_service.dart';
import 'package:evencir_task/core/api_services/end_points.dart';
import 'package:evencir_task/model/product_page_model.dart';
import 'package:evencir_task/widgets/loader/easy_loading.dart';
import 'package:evencir_task/widgets/toaster/toaster.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProductPageProvider extends ChangeNotifier {
  ProductPageModel? _productPageModel;
  List<Product> _filteredProducts = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _searchQuery = '';

  // Getters
  ProductPageModel? get productPageModel => _productPageModel;
  List<Product> get allProducts => _productPageModel?.products ?? [];
  List<Product> get products =>
      _searchQuery.isEmpty ? allProducts : _filteredProducts;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;

  // Method to fetch products from API
  Future<void> fetchProducts() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Show loading indicator
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

  // Method to search/filter products
  void searchProducts(String query) {
    _searchQuery = query;

    if (query.isEmpty) {
      _filteredProducts = [];
    } else {
      _filteredProducts = allProducts.where((product) {
        final titleMatch =
            product.title?.toLowerCase().contains(query.toLowerCase()) ?? false;
        final brandMatch =
            product.brand?.toLowerCase().contains(query.toLowerCase()) ?? false;
        final categoryMatch =
            product.category?.toLowerCase().contains(query.toLowerCase()) ??
                false;

        return titleMatch || brandMatch || categoryMatch;
      }).toList();
    }

    notifyListeners();
  }

  // Method to retry fetching products
  void retryFetch() {
    fetchProducts();
  }

  // Method to clear search
  void clearSearch() {
    _searchQuery = '';
    _filteredProducts = [];
    notifyListeners();
  }
}
