class ProducCategory {
  final String category;
  final List<Product> products;

  const ProducCategory({required this.category, required this.products});
}

class Product {
  final String name, image, description, price;

  const Product(
      {required this.name,
      required this.image,
      required this.description,
      required this.price});
}
