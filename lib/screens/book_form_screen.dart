
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book_model.dart';
import '../providers/book_provider.dart';

class BookFormScreen extends StatefulWidget {
  
  final Book? book; 
  const BookFormScreen({super.key, this.book});

  @override
  State<BookFormScreen> createState() => _BookFormScreenState();
}

class _BookFormScreenState extends State<BookFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _categoryController;
  late TextEditingController _quantityController;

  bool get isEditing => widget.book != null;

  @override
  void initState() {
    super.initState();
    
    _titleController = TextEditingController(text: isEditing ? widget.book!.title : '');
    _authorController = TextEditingController(text: isEditing ? widget.book!.author : '');
    _categoryController = TextEditingController(text: isEditing ? widget.book!.category : '');
    _quantityController = TextEditingController(text: isEditing ? widget.book!.quantity.toString() : '1');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _categoryController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  
  void _saveBook() {
    if (_formKey.currentState!.validate()) {
      final provider = context.read<BookProvider>();
      final newBook = Book(
        id: isEditing ? widget.book!.id : '', 
        title: _titleController.text,
        author: _authorController.text,
        category: _categoryController.text,
        quantity: int.parse(_quantityController.text),
      );

      if (isEditing) {
       
        provider.updateBook(newBook);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cập nhật sách thành công!'), backgroundColor: Colors.green),
        );
      } else {
        
        provider.addBook(newBook);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Thêm sách thành công!'), backgroundColor: Colors.green),
        );
      }
      Navigator.of(context).pop(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Sửa Sách' : 'Thêm Sách Mới'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Input Tiêu đề
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Tên Sách', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tên sách.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Tác Giả', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tác giả.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Thể Loại', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập thể loại.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Số Lượng', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Số lượng phải là số nguyên dương.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
  
              ElevatedButton.icon(
                onPressed: _saveBook,
                icon: const Icon(Icons.save),
                label: Text(isEditing ? 'LƯU THAY ĐỔI' : 'THÊM SÁCH'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}