class Book {
  final String id;
  final String title; 
  final String author; 
  final String category; 
  final int quantity; 

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.quantity,
  });

  
  factory Book.fromMap(Map<String, dynamic> data, String documentId) {
    return Book(
      id: documentId,
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      category: data['category'] ?? '',
      quantity: data['quantity'] ?? 0,
    );
  }

  
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'category': category,
      'quantity': quantity,
    };
  }
}