import 'dart:convert';

List<CategoriesPageModel> categoriesPageModelFromJson(String str) =>
    List<CategoriesPageModel>.from(
        json.decode(str).map((x) => CategoriesPageModel.fromJson(x)));

String categoriesPageModelToJson(List<CategoriesPageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriesPageModel {
  String? slug;
  String? name;
  String? url;

  CategoriesPageModel({
    this.slug,
    this.name,
    this.url,
  });

  factory CategoriesPageModel.fromJson(Map<String, dynamic> json) =>
      CategoriesPageModel(
        slug: json["slug"],
        name: json["name"],
        url: json["url"],
      );

  // Alternative constructor for when we receive a string instead of a map
  factory CategoriesPageModel.fromString(String categoryName) {
    String formattedName = categoryName.replaceAll('-', ' ');
    formattedName = formattedName.split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');

    return CategoriesPageModel(
      slug: categoryName,
      name: formattedName,
      url: 'https://dummyjson.com/products/category/$categoryName',
    );
  }

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "url": url,
      };

  @override
  String toString() {
    return 'CategoriesPageModel(slug: $slug, name: $name, url: $url)';
  }
}
