import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chingu Project',
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController editingController = TextEditingController();
  final duplicateItems = List<String>.generate(10, (i) => "Item $i");
  var items = List<String>();

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);

    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
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
        items.addAll(duplicateItems);
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
                        items[index].toString(),
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
    Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
  }
}

class SubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Page'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Click button to back to Main Page'),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.redAccent,
              child: Text('Back to Main Page'),
              onPressed: () {
                // TODO
              },
            )
          ],
        ),
      ),
    );
  }
}
