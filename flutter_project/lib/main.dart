import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'article_list.dart';

Future<void> main() async {
  var data = await parseJson();
  runApp(MyApp(
    data: data,
  ));
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

  void filterSearchResults(String query) {
    List<dynamic> dummySearchList = List<dynamic>();
    dummySearchList.addAll(data);

    if (query.isNotEmpty) {
      List<dynamic> dummyListData = List<dynamic>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Container(
          child: Column(children: <Widget>[
        _buildSearchBar(),
        Container(
            constraints: BoxConstraints(minHeight: 50),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: _buildArticleHeader())),
        Container(
            constraints: BoxConstraints(minWidth: 250, maxHeight: 250),
            child: _buildArticleListView()),
      ])),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: editingController,
      onChanged: (value) {
        filterSearchResults(value);
      },
      decoration: InputDecoration(
        labelText: "Search",
        hintText: "Search",
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget _buildArticleHeader() {
    return Row(children: [
      Expanded(
        child: Text('Articles'),
      ),
      InkWell(
        child: Text(
          'All Articles',
          style: new TextStyle(
            color: Colors.blue,
          ),
          textAlign: TextAlign.right,
        ),
        onTap: () {
          navigateToSubPage(context);
        },
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
                      Image.network(
                          'https://media.sproutsocial.com/uploads/2017/02/10x-featured-social-media-image-size.png'),
                      Text(
                        items[index]['title'].toString(),
                      )
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



Future<String> _loadFromAsset() async {
  return await rootBundle.loadString("assets/articles.json");
}

Future parseJson() async {
  String jsonString = await _loadFromAsset();
  return jsonDecode(jsonString);
}
