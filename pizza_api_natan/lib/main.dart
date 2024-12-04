import 'package:flutter/material.dart';
import 'package:pizza_api_natan/httphelper.dart';
import 'package:pizza_api_natan/pizza.dart';
import 'package:pizza_api_natan/pizza_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Pizza>> callPizzas() async {
    Httphelper helper = Httphelper();
    List<Pizza> pizzas = await helper.getPizzaList();
    return pizzas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSON')),
      body: FutureBuilder<List<Pizza>>(
          future: callPizzas(),
          builder: (BuildContext context, AsyncSnapshot<List<Pizza>> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return ListView.builder(
                itemCount: (snapshot.data == null) ? 0 : snapshot.data!.length,
                itemBuilder: (BuildContext context, int position) {
                  return ListTile(
                    title: Text(snapshot.data![position].pizzaName),
                    subtitle: Text(snapshot.data![position].description +
                        ' - € ' +
                        snapshot.data![position].price.toString()),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PizzaDetailScreen(
                            pizza: snapshot.data![position],
                            isNew: false,
                          ),
                        ),
                      );
                    },
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PizzaDetailScreen(
                        pizza: Pizza(
                          id: 0, // Default ID
                          pizzaName: '', // Nama kosong untuk pizza baru
                          description: '', // Deskripsi kosong
                          price: 0.0, // Harga default
                          imageUrl: '', // URL gambar kosong
                        ),
                        isNew: true,
                      )),
            );
          }),
    );
  }
}
