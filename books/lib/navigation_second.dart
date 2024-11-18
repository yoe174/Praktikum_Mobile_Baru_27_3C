import 'package:flutter/material.dart';

class NavigationSecond extends StatefulWidget {
  const NavigationSecond({super.key});

  @override
  State<NavigationSecond> createState() => _NavigationSecondState();
}

class _NavigationSecondState extends State<NavigationSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Second Screen Natan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, // Warna latar belakang tombol
                ),
                child: const Text('Pink',style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.pop(context, Colors.pink);
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // Warna latar belakang tombol
                ),
                child: const Text('Purple',style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.pop(context, Colors.purple);
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow, // Warna latar belakang tombol
                ),
                child: const Text('Yellow',style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.pop(context, Colors.yellow);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
