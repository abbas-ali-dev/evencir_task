import 'package:evencir_task/model/product_page_model.dart';
import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Product> _favoriteProducts = [];
  List<Product> _filteredFavorites = [];
  String _searchQuery = '';

  List<Product> get favoriteProducts => _favoriteProducts;
  List<Product> get filteredFavorites =>
      _searchQuery.isEmpty ? _favoriteProducts : _filteredFavorites;
  String get searchQuery => _searchQuery;

  bool isFavorite(Product product) {
    return _favoriteProducts.any((p) => p.id == product.id);
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      _favoriteProducts.removeWhere((p) => p.id == product.id);
    } else {
      _favoriteProducts.add(product);
    }

    if (_searchQuery.isNotEmpty) {
      searchFavorites(_searchQuery);
    }

    notifyListeners();
  }

  void searchFavorites(String query) {
    _searchQuery = query;

    if (query.isEmpty) {
      _filteredFavorites = [];
    } else {
      _filteredFavorites = _favoriteProducts.where((product) {
        final titleMatch =
            product.title?.toLowerCase().contains(query.toLowerCase()) ?? false;
        final brandMatch =
            product.brand?.toLowerCase().contains(query.toLowerCase()) ?? false;
        final categoryMatch =
            product.category?.toLowerCase().contains(query.toLowerCase()) ??
                false;
        final descriptionMatch =
            product.description?.toLowerCase().contains(query.toLowerCase()) ??
                false;

        return titleMatch || brandMatch || categoryMatch || descriptionMatch;
      }).toList();
    }

    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _filteredFavorites = [];
    notifyListeners();
  }
}
