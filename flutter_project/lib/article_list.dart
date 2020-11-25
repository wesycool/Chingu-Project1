import 'package:flutter/material.dart';

void main() {
  runApp(SubPage());
}

class SubPage extends StatelessWidget {
  final List<String> items;
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
        return Container(child: Text(items[index].toString()));
      },
    );
  }
}
