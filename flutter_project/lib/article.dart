import 'package:flutter/material.dart';

class SingleArticle extends StatelessWidget {
  final Map<String, dynamic> article;
  SingleArticle({Key key, @required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article['title'])),
      body: Container(child: Text(article['description'])),
    );
  }
}
