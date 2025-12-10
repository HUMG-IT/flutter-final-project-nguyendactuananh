import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book_model.dart';
import '../providers/book_provider.dart';
import 'book_form_screen.dart'; 

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
          
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const BookFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.library_books, size: 60, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("Chưa có cuốn sách nào.", style: TextStyle(color: Colors.grey)),
                  Text("Bấm nút + để thêm mới.", style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }
          final books = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  // Bấm vào để SỬA
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        
                        builder: (context) => BookFormScreen(book: book),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      book.quantity.toString(),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ), 
                  ),
                  title: Text(
                    book.title, 
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tác giả: ${book.author}"),
                      Text("Thể loại: ${book.category}", style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                    ],
                  ),
                  // Nút XÓA
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Xác nhận xóa'),
                          content: Text('Bạn có chắc muốn xóa cuốn "${book.title}" không?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(),
                              child: const Text('Hủy'),
                            ),
                            TextButton(
                              onPressed: () {
                                
                                context.read<BookProvider>().deleteBook(book.id);
                                Navigator.of(ctx).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Đã xóa sách')),
                                );
                              },
                              child: const Text('Xóa', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
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