import 'package:flutter/material.dart';
import 'package:community_website/models/post.dart';
import 'package:community_website/services/api_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  String _author = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final post = Post(id: '', title: _title, content: _content, author: _author);
      ApiService.createPost(post).then((_) {
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $error')));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('게시글 작성'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: '제목'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '제목을 입력하세요';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '내용'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '내용을 입력하세요';
                  }
                  return null;
                },
                onSaved: (value) {
                  _content = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '작성자'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '작성자를 입력하세요';
                  }
                  return null;
                },
                onSaved: (value) {
                  _author = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('작성하기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
