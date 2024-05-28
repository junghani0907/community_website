class Post {
  final String id;
  final String title;
  final String content;
  final String author;

  Post({required this.id, required this.title, required this.content, required this.author});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      title: json['title'],
      content: json['content'],
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'author': author,
    };
  }
}
