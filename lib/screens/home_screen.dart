// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book_model.dart';
import '../providers/book_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thư viện Sách'),
        centerTitle: true,
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Chức năng thêm sẽ làm ở bước sau!")),
          );
        },
        child: const Icon(Icons.add),
      ),
      // Phần thân hiển thị danh sách
      body: StreamBuilder<List<Book>>(
        
        stream: context.read<BookProvider>().booksStream,
        builder: (context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          
          if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          }

          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Chưa có cuốn sách nào."));
          }

          
          final books = snapshot.data!;
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(book.quantity.toString()), 
                  ),
                  title: Text(book.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("${book.author} - ${book.category}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<BookProvider>().deleteBook(book.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}