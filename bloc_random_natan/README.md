# **bloc_random_natan**

## **Pratikum 7**

### **Langkah 1**

Buatlah sebuah project flutter baru dengan nama bloc_random_nama (beri nama panggilan Anda)

### **Langkah 2**

Lalu buat file baru di folder lib dengan nama random_bloc.dart Ketik kode impor berikut ini.
```
import 'dart:async';
import 'dart:math';
```
### **Langkah 3**

Buat class RandomNumberBloc()
```
class RandomNumberBloc {}
```
### **Langkah 4**

Buat variabel StreamController Di dalam class RandomNumberBloc() ketik variabel berikut ini
```
final _generateRandomController = StreamController<void>();
  final _randomNumberController = StreamController<int>();
  Sink<void> get generateRandom => _generateRandomController.sink;
  Stream<int> get randomNumber => _randomNumberController.stream;
```
### **Langkah 5**

Buat constructor
```
RandomNumberBloc() {
    _generateRandomController.stream.listen((_) {
      final random = Random().nextInt(10);
      _randomNumberController.sink.add(random);
    });
  }
```
### **Langkah 6**

Buat method dispose()
```
void dispose() {
    _generateRandomController.close();
    _randomNumberController.close();
  }
```
### **Langkah 7**

Edit main.dart
```
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const RandomScreen(),
    );
  }
}
```
### **Langkah 8**

Buat file baru random_screen.dart Di dalam folder lib project Anda, buatlah file baru ini.

### **Langkah 9**

Lakukan impor material dan random_bloc.dart Ketik kode ini di file baru random_screen.dart
```
import 'package:flutter/material.dart';
import 'random_bloc.dart';
```
### **Langkah 10**

Buat StatefulWidget RandomScreen Buatlah di dalam file random_screen.dart
```
class RandomScreen extends StatefulWidget {
  const RandomScreen({super.key});

  @override
  State<RandomScreen> createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
```
### **Langkah 11**

Buat variabel, Ketik kode ini di dalam class _RandomScreenState
```
final _bloc = RandomNumberBloc();
```
### **Langkah 12**

Buat method dispose() Ketik kode ini di dalam class _StreamHomePageState
```
@override
  void dispose(){
    _bloc.dispose();
    super.dispose();
  }
```
### **Langkah 13**

Edit method build(), Ketik kode ini di dalam class _StreamHomePageState
```
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Number')),
      body: Center(
        child: StreamBuilder(stream: _bloc.randomNumber,
        initialData: 0, 
        builder: (context, snapshot) {
          return Text(
            'Random Number : ${snapshot.data}',style: const TextStyle(fontSize: 24),
          );
        }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _bloc.generateRandom.add(null),
        child: const Icon(Icons.refresh),
        ),
    );
  }
```

### ```Soal 13```

* Jelaskan maksud praktikum ini ! Dimanakah letak konsep pola BLoC-nya ?

**jawab**

***Maksud Praktikum***

Praktikum ini bertujuan untuk memahami dan mengimplementasikan pola BLoC (Business Logic Component) pada aplikasi Flutter. Pola ini membantu memisahkan logika bisnis dari antarmuka pengguna (UI) untuk memudahkan:

* Manajemen State: Memastikan state aplikasi dapat diakses secara konsisten di berbagai bagian aplikasi.
* Modularitas: Membuat logika bisnis independen dari UI, sehingga lebih mudah diisolasi untuk pengujian.
* Reusabilitas: Logika yang sama dapat digunakan kembali di beberapa bagian aplikasi atau bahkan aplikasi berbeda.

***Letak Konsep Pola BLoC***

Konsep pola BLoC terletak pada pembagian peran antara BLoC (logika bisnis) dan UI (presentasi):

1. Logika Bisnis di BLoC
Terimplementasi di file random_bloc.dart:

**Stream dan Sink:**
* generateRandom menerima event dari UI.
* randomNumber mengirimkan data ke UI.

**Proses di Tengah:**
* Event di generateRandom diproses untuk menghasilkan angka acak.
* Angka acak ini disalurkan melalui randomNumber.

2. UI Mendengarkan Data (Stream)
Terimplementasi di file random_screen.dart:

**StreamBuilder:**
* Mendengarkan stream randomNumber dari BLoC.
* Memperbarui tampilan setiap kali stream menghasilkan data baru.

**Event Trigger:**
* Tombol refresh pada FAB mengirimkan event ke sink generateRandom


* Capture hasil praktikum Anda berupa GIF dan lampirkan di README.

![Screenshoot yonatan](image/soal-13.gif)