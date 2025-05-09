import 'package:flutter/material.dart';
import 'package:evencir_task/core/api_services/dio_service.dart';
import 'package:evencir_task/core/api_services/end_points.dart';
import 'package:evencir_task/model/categories_page_model.dart';
import 'package:evencir_task/widgets/loader/easy_loading.dart';
import 'package:evencir_task/widgets/toaster/toaster.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CategoriesPageProvider extends ChangeNotifier {
  List<CategoriesPageModel> _categories = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<CategoriesPageModel> get categories => _categories;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  CategoriesPageProvider();

  Future<void> fetchCategories() async {
    try {
      _isLoading = true;
      notifyListeners();

      await Easyloding.configLoading();
      EasyLoading.show(status: 'Loading categories...');

      final response = await NetworkManager().callApi(
        method: HttpMethod.Get,
        urlEndPoint: EndPoints.categories,
      );

      if (response != null && response.statusCode == 200) {
        debugPrint("Categories API Response: ${response.data}");

        final List<dynamic> categoriesData = response.data;

        _categories = [];

        for (var categoryData in categoriesData) {
          if (categoryData is Map<String, dynamic>) {
            _categories.add(CategoriesPageModel.fromJson(categoryData));
          } else if (categoryData is String) {
            _categories.add(CategoriesPageModel(
              slug: categoryData,
              name: _formatCategoryName(categoryData),
              url: 'https://dummyjson.com/products/category/$categoryData',
            ));
          }
        }

        debugPrint("Processed Categories: ${_categories.length}");
        for (var category in _categories) {
          debugPrint("Category: ${category.name}, Slug: ${category.slug}");
        }

        _errorMessage = '';
      } else {
        _errorMessage =
            'Failed to load categories. Status code: ${response?.statusCode}';
        debugPrint("Error: $_errorMessage");
        await Toaster.showToast(_errorMessage);
      }
    } catch (e) {
      _errorMessage = 'Error fetching categories: ${e.toString()}';
      debugPrint("Exception: $_errorMessage");
      await Toaster.showToast(_errorMessage);
    } finally {
      _isLoading = false;
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  String _formatCategoryName(String slug) {
    String name = slug.replaceAll('-', ' ');

    name = name.split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');

    return name;
  }

  void retryFetch() {
    fetchCategories();
  }
}
