import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/book_provider.dart';
import 'screens/home_screen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyATxSpoLKPF05dFUmQDk57uZur1QSynApw", 
      authDomain: "book-management-app-60b2c.firebaseapp.com",
      projectId: "book-management-app-60b2c",
      storageBucket: "book-management-app-60b2c.firebasestorage.app",
      messagingSenderId: "310459163484",
      appId: "1:310459163484:web:d4d22bb1bc7ac4de565799",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quản lý Sách',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const HomeScreen(), 
      ),
    );
  }
}