import 'package:flutter/material.dart';

class SingleArticle extends StatelessWidget {
  final Map<String, dynamic> article;
  final BuildContext context;
  SingleArticle({Key key, @required this.context, @required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article['title'])),
      body: SingleChildScrollView(child: Center(child: _buildArticleContent())),
    );
  }

  Widget _buildArticleContent() {
    return Column(children: [
      Container(
        constraints: BoxConstraints(maxHeight: 300),
        child: Image.network(article['imgLink'].toString()),
      ),
      Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ListTile(
            title: Text('About ${article["title"]}'),
            subtitle:
                Container(child: _buildAboutContent(article['description'])),
          ))
    ]);
  }

  Widget _buildAboutContent(description) {
    List<String> desc = description.split('\n');
    return Column(children: [
      for (var text in desc)
        Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 15),
            child: Text(text)),
    ]);
  }
}
