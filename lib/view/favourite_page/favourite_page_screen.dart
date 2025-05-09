import 'package:evencir_task/constants/text_styles.dart';
import 'package:evencir_task/provider/favorites_provider.dart';
import 'package:evencir_task/widgets/custom_widgets/custom_favorite_card.dart';
import 'package:evencir_task/widgets/custom_widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePageScreen extends StatelessWidget {
  const FavouritePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 15.0, right: 15.0),
          child: Column(
            children: [
              const Text(
                'Favourites',
                style: AppTextStyles.headingPlayfair,
              ),
              CustomSearchBar(
                hintText: 'Search in favorites',
                controller: searchController,
                onChanged: (query) {
                  final favoritesProvider =
                      Provider.of<FavoritesProvider>(context, listen: false);
                  favoritesProvider.searchFavorites(query);
                },
              ),
            ],
          ),
        ),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          final favoriteProducts = favoritesProvider.filteredFavorites;

          if (favoritesProvider.favoriteProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No favorites yet',
                    style: AppTextStyles.bodyPoppins.copyWith(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start adding products to your favorites',
                    style: AppTextStyles.bodyPoppins.copyWith(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          if (favoriteProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search_off,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No matching favorites',
                    style: AppTextStyles.bodyPoppins.copyWith(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try a different search term',
                    style: AppTextStyles.bodyPoppins.copyWith(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                child: Text(
                  '${favoriteProducts.length} favorite products',
                  style: AppTextStyles.bodyPoppins.copyWith(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemCount: favoriteProducts.length,
                  itemBuilder: (context, index) {
                    final product = favoriteProducts[index];
                    return CustomFavoriteCard(product: product);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
