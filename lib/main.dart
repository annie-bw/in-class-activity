import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Navigation',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Product Navigation'),
    );
  }
}

class Product {
  final String name;
  final String description;
  final int price;
  final String imageLabel;
  final Color imageColor;

  const Product(
    this.name,
    this.description,
    this.price,
    this.imageLabel,
    this.imageColor,
  );

  static List<Product> getProducts() {
    return const [
      Product('Pixel', 'Pixel is the most featureful phone ever', 800,
          'pixel 1', Color(0xFF3F64D8)),
      Product('Laptop', 'Laptop is most productive development tool', 2000,
          'laptop', Color(0xFF3ED43A)),
      Product('Tablet', 'Tablet is the most useful device ever for meeting',
          1500, 'tablet', Color(0xFFCFC433)),
      Product('Pendrive', 'iPhone is the stylist phone ever', 100,
          'pen drive', Color(0xFFC45C3E)),
      Product('Floppy Drive', 'iPhone is the stylist phone ever', 20,
          'floppy', Color(0xFF3FBFAA)),
      Product('iPhone', 'iPhone is the stylist phone ever', 1000, 'iphone',
          Color(0xFF8E44AD)),
    ];
  }
}

/// Stand-in for the product image: a coloured block with the product label.
class ProductImage extends StatelessWidget {
  final Product product;
  final double fontSize;

  const ProductImage({super.key, required this.product, this.fontSize = 32});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: product.imageColor,
      alignment: Alignment.center,
      child: Text(
        product.imageLabel,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  final List<Product> items = Product.getProducts();

  MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: ProductBox(item: items[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(item: items[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductPage extends StatelessWidget {
  final Product item;

  const ProductPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // The AppBar automatically shows a back button that pops this route.
    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 250,
            child: ProductImage(product: item, fontSize: 80),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(item.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(item.description),
                  Text('Price: ${item.price}'),
                  const RatingBox(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  final Product item;

  const ProductBox({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 140,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(width: 145, child: ProductImage(product: item)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(item.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(item.description, textAlign: TextAlign.center),
                    Text('Price: ${item.price}'),
                    const RatingBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingBox extends StatefulWidget {
  const RatingBox({super.key});

  @override
  State<RatingBox> createState() => _RatingBoxState();
}

class _RatingBoxState extends State<RatingBox> {
  int _rating = 0;

  void _setRating(int value) {
    setState(() => _rating = value);
  }

  @override
  Widget build(BuildContext context) {
    const double size = 20;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(3, (i) {
        return IconButton(
          icon: Icon(
            _rating > i ? Icons.star : Icons.star_border,
            size: size,
          ),
          color: Colors.red[500],
          iconSize: size,
          onPressed: () => _setRating(i + 1),
        );
      }),
    );
  }
}
