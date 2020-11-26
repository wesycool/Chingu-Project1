import 'package:flutter/material.dart';
import 'article.dart';

class AllArticles extends StatelessWidget {
  final List<dynamic> articles;
  final BuildContext context;
  AllArticles({Key key, @required this.context, @required this.articles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Articles')),
      body: Container(
          margin: const EdgeInsets.only(
              top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
          child: _buildAllArticlesListView()),
    );
  }

  Widget _buildAllArticlesListView() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];

        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(5),
            isThreeLine: true,
            title: Text(article['title']),
            subtitle: Text(article['description'].split('\n')[0]),
            leading: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 100),
              child: Image.network(article['imgLink'].toString()),
            ),
            onTap: () => navigateToSingleArticle(articles[index]),
          ),
        );
      },
    );
  }

  navigateToSingleArticle(article) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SingleArticle(context: context, article: article)));
  }
}
