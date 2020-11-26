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
        return Container(
          constraints: BoxConstraints(maxHeight: 100),
          child: InkWell(
            onTap: () => navigateToSingleArticle(articles[index]),
            child: _buildArticleCard(articles[index]),
          ),
        );
      },
    );
  }

  Widget _buildArticleCard(article) {
    return Card(
        child: Row(children: <Widget>[
      Container(
        constraints: BoxConstraints(minWidth: 150),
        child: Image.network(article['imgLink'].toString()),
      ),
      Container(
        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(article['title']),
            Text(article['description']),
          ],
        ),
      ),
    ]));
  }

  navigateToSingleArticle(article) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SingleArticle(article: article)));
  }
}
