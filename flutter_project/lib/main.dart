import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'article_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var data = await parseJson();
  runApp(MyApp(data: data));
}

class MyApp extends StatelessWidget {
  final List<dynamic> data;
  MyApp({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chingu Project',
      home: Dashboard(data: data),
    );
  }
}

class Dashboard extends StatefulWidget {
  final List<dynamic> data;
  Dashboard({Key key, @required this.data}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState(data: data);
}

class _DashboardState extends State<Dashboard> {
  final List<dynamic> data;
  _DashboardState({@required this.data});

  TextEditingController editingController = TextEditingController();
  var items = List<dynamic>();

  @override
  void initState() {
    items.addAll(data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Container(
          child: Column(children: <Widget>[
        _buildSearchBar(),
        Container(
            constraints: BoxConstraints(minHeight: 50),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: _buildArticleHeader())),
        Container(
            alignment: Alignment.centerLeft,
            constraints: BoxConstraints(minWidth: 250, maxHeight: 250),
            child: _buildArticleListView()),
      ])),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: editingController,
      onChanged: (value) => filterSearchResults(value),
      decoration: InputDecoration(
        labelText: "Search",
        hintText: "Search",
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  void filterSearchResults(String query) {
    List<dynamic> filteredList = data
        .where((item) => query.isEmpty || item['title'].contains(query))
        .toList();

    setState(() {
      items.clear();
      items.addAll(filteredList);
    });
  }

  Widget _buildArticleHeader() {
    return Row(children: [
      Expanded(child: Text('Articles')),
      InkWell(
        child: Text(
          'All Articles',
          style: new TextStyle(color: Colors.blue),
          textAlign: TextAlign.right,
        ),
        onTap: () => navigateToSubPage(context),
      ),
    ]);
  }

  Widget _buildArticleListView() {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Card(
              child: Container(
                child: Center(
                  child: Container(
                    child: Column(children: [
                      Container(
                          constraints: BoxConstraints(maxHeight: 200),
                          child: Image.network(
                              items[index]['imgLink'].toString())),
                      Text(items[index]['title'])
                    ]),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future navigateToSubPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SubPage(items: data)));
  }
}

Future parseJson() async {
  String jsonString = await rootBundle.loadString("assets/articles.json");
  return jsonDecode(jsonString);
}
