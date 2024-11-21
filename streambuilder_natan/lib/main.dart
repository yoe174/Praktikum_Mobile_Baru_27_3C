import 'package:flutter/material.dart';
import 'stream.dart';
import 'dart:async';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: const StreamHomepage(),
    );
  }
}

class StreamHomepage extends StatefulWidget {
  const StreamHomepage({super.key});

  @override
  State<StreamHomepage> createState() => _StreamHomePageState();
}

class _StreamHomePageState extends State<StreamHomepage> {
  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream'),
      ),
      body: StreamBuilder(
        stream: numberStream,
        initialData: 0,
        builder: (context, Snapshot) {
          if (Snapshot.hasError) {
            print('Error');
          }
          if (Snapshot.hasData) {
            return Center(
              child: Text(
                Snapshot.data.toString(),
                  style: const TextStyle(fontSize: 96),
              )
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  late Stream<int> numberStream;

  @override
  void initState() {
    numberStream = NumberStream().getNumber();
    super.initState();
  }
}

