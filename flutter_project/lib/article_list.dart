import 'package:flutter/material.dart';

class SubPage extends StatelessWidget {
  final List<dynamic> items;
  SubPage({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Articles'),
      ),
      body: Container(
        child: _buildFullListListView(),
      ),
    );
  }

  Widget _buildFullListListView() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Container(child: Text(items[index]['title'].toString()));
      },
    );
  }
}
