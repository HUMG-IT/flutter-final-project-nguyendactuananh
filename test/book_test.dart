
import 'package:book_manager/models/book_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  
  test('Book.fromMap should convert Map to Book object correctly', () {
    final Map<String, dynamic> data = {
      'title': 'The Great Gatsby',
      'author': 'F. Scott Fitzgerald',
      'category': 'Classic',
      'quantity': 10,
    };
    const String docId = 'bookId123';
    
    final book = Book.fromMap(data, docId);

    expect(book.id, docId);
    expect(book.title, 'The Great Gatsby');
    expect(book.author, 'F. Scott Fitzgerald');
    expect(book.quantity, 10);
  });

  test('Book.toMap should convert Book object to Map correctly', () {
    final book = Book(
      id: 'bookId456',
      title: '1984',
      author: 'George Orwell',
      category: 'Dystopian',
      quantity: 5,
    );

    final map = book.toMap();

    expect(map['title'], '1984');
    expect(map['author'], 'George Orwell');
    expect(map['quantity'], 5);
    expect(map.containsKey('id'), false); 
  });

  test('Book.fromMap should handle missing fields gracefully', () {
    final Map<String, dynamic> data = {
      'title': 'Test Book',
      
    };
    const String docId = 'testId';

    final book = Book.fromMap(data, docId);

    expect(book.title, 'Test Book');
    expect(book.author, ''); 
    expect(book.quantity, 0); 
  });
}