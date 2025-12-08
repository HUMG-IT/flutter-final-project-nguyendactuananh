import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book_model.dart';

class BookProvider extends ChangeNotifier {
  final CollectionReference _db = FirebaseFirestore.instance.collection('books');

  // 1. CREATE: Thêm sách mới
  Future<void> addBook(Book book) async {
    await _db.add(book.toMap());
    notifyListeners();
  }

  Stream<List<Book>> get booksStream {
    return _db.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Book.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  
  Future<void> updateBook(Book book) async {
    await _db.doc(book.id).update(book.toMap());
    notifyListeners();
  }

  Future<void> deleteBook(String id) async {
    await _db.doc(id).delete();
    notifyListeners();
  }
}