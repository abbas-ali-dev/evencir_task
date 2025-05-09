import 'package:evencir_task/model/product_page_model.dart';
import 'package:evencir_task/provider/favorites_provider.dart';
import 'package:evencir_task/widgets/toaster/toaster.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsProvider extends ChangeNotifier {
  Product? _product;
  late final BuildContext _context;

  ProductDetailsProvider(this._context);

  Product? get product => _product;

  bool get isFavorite {
    if (_product == null) return false;
    return Provider.of<FavoritesProvider>(_context, listen: false)
        .isFavorite(_product!);
  }

  void setProduct(Product product) {
    _product = product;
    notifyListeners();
  }

  void toggleFavorite() {
    if (_product == null) return;

    if (isFavorite == true) {
      Toaster.showToast('Product remove from favorites');
    } else {
      Toaster.showToast('Product added to favorites');
    }

    Provider.of<FavoritesProvider>(_context, listen: false)
        .toggleFavorite(_product!);

    notifyListeners();
  }
}
