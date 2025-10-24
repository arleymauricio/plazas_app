import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/features/markets/data/repositories/market_repository_impl.dart';
import 'package:myapp/features/markets/domain/entities/market_entity.dart';
import 'package:myapp/features/markets/domain/usecases/add_market_usecase.dart';
import 'package:myapp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void _addMarket(BuildContext context) async {
    final firestore = FirebaseFirestore.instance;
    final repository = MarketRepositoryImpl(firestore: firestore);
    final addMarketUseCase = AddMarketUseCase(repository: repository);

    final market = MarketEntity(
      id: '3',
      name: 'Live Market',
      description: 'This market was added live from the app!',
      address: '456 Live Avenue',
      imageUrl: 'live_market_image',
    );

    await addMarketUseCase(market);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Market added to Firestore!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Market Adder'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _addMarket(context),
          child: const Text('Add Market to Firestore'),
        ),
      ),
    );
  }
}
