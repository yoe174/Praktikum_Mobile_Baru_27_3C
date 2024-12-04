import 'package:flutter/material.dart';
import 'pizza.dart';
import 'httphelper.dart';

class PizzaDetailScreen extends StatefulWidget {
  // const PizzaDetailScreen({super.key});

  final Pizza pizza;
  final bool isNew;
  const PizzaDetailScreen(
    {super.key, required this.pizza, required this.isNew}
  );

  @override
  State<PizzaDetailScreen> createState() => _PizzaDetailScreenState();
}

class _PizzaDetailScreenState extends State<PizzaDetailScreen> {
  final TextEditingController txtId = TextEditingController();
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtPrice = TextEditingController();
  final TextEditingController txtImageUrl = TextEditingController();
  String operationResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pizza Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                operationResult,
                style: TextStyle(
                  backgroundColor: Colors.green[200],
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: txtId,
                decoration: const InputDecoration(
                  hintText: 'Insert ID',
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: txtName,
                decoration: const InputDecoration(
                  hintText: 'Insert Pizza Name',
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: txtDescription,
                decoration: const InputDecoration(
                  hintText: 'Insert Description',
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: txtPrice,
                decoration: const InputDecoration(
                  hintText: 'Insert Price',
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: txtImageUrl,
                decoration: const InputDecoration(
                  hintText: 'Insert Image URL',
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  postPizza();
                },
                child: const Text('Send Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    txtId.dispose();
    txtName.dispose();
    txtDescription.dispose();
    txtPrice.dispose();
    txtImageUrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (!widget.isNew) {
      txtId.text = widget.pizza.id.toString();
      txtName.text = widget.pizza.pizzaName;
      txtDescription.text = widget.pizza.description;
      txtPrice.text = widget.pizza.price.toString();
      txtImageUrl.text = widget.pizza.imageUrl;
    }
    super.initState();
  }

  Future<void> postPizza() async {
    Httphelper helper = Httphelper();
    Pizza pizza = Pizza(
      id: int.tryParse(txtId.text) ?? 0, // Gunakan default value jika null
      pizzaName: txtName.text,
      description: txtDescription.text,
      price: double.tryParse(txtPrice.text) ??
          0.0, // Gunakan default value jika null
      imageUrl: txtImageUrl.text,
    );

    String result = await helper.postPizza(pizza);

    setState(() {
      operationResult = result;
    });
  }

    Future<void> savePizza() async {
    Httphelper helper = Httphelper();

    Pizza pizza = Pizza(
      id: int.tryParse(txtId.text) ?? 0, // Gunakan default value jika null
      pizzaName: txtName.text,
      description: txtDescription.text,
      price: double.tryParse(txtPrice.text) ??
          0.0, // Gunakan default value jika null
      imageUrl: txtImageUrl.text,
    );

    final result =
        await (widget.isNew ? helper.postPizza(pizza) : helper.putPizza(pizza));
    setState(() {
      operationResult = result;
    });
  }
}
