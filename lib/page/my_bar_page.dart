import 'package:flutter/material.dart';

import 'page.dart';

class MyBarPage extends StatefulWidget with PageWithTitle {
  MyBarPage({this.title: ''}) : assert(title != null);

  final String title;

  @override
  _MyBarPageState createState() => _MyBarPageState();
}

class _MyBarPageState extends State<MyBarPage>
    with SingleTickerProviderStateMixin, RestorationMixin {
  TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_scrollable_bar';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_bar');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        indicatorColor: Theme.of(context).tabBarTheme.labelColor,
        controller: _tabController,
        tabs: [
          Tab(text: 'First'),
          Tab(text: 'My Ingredients'),
          Tab(text: 'My Cocktails'),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Container(
              height: 100,
              width: 100,
              color: Colors.red,
            ),
          ),
          Center(
            child: Container(
              height: 100,
              width: 100,
              color: Colors.blue,
            ),
          ),
          Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {}
            ),
          ),
        ],
      ),
    );
  }
}

/// Tool filler
// void setData() async {
//   var dataToWrite = await getPostgresData();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var collection = _firebase.collection(collectionName);
//
//   if (!prefs.containsKey(lastWritten)) {
//     prefs.setInt(lastWritten, 0);
//   }
//
//   for (var row in dataToWrite) {
//     if (row[0] > prefs.get(lastWritten)) {
//
//       Map<String, dynamic> toolData = {
//         id: row[0],
//         group: groupDefault,
//         imageSource: row[3],
//       };
//
//
//       var newToolDocRef = await collection.add(toolData);
//       var localeCollection = newToolDocRef.collection(subcollectionName);
//
//       Map<String, dynamic> toolLocaleData = {
//         title: row[1],
//         description: row[2],
//       };
//
//       await localeCollection.doc('ru').set(toolLocaleData);
//
//       prefs.setInt(lastWritten, int.parse(row[0].toString()));
//
//       print('Tool added.');
//     }
//   }
// }

//
//
// Future<List<List>> getPostgresData() async {
//   if (_postgreSQLConnection.isClosed) {
//     await _postgreSQLConnection.open();
//   }
//
//   print(_postgreSQLConnection.isClosed.toString());
//
//   List<List<dynamic>> results =
//   await _postgreSQLConnection.query("SELECT * FROM cocktails ORDER BY id");
//
//   return results;
// }
//
// void setData() async {
//   var dataToWrite = await getPostgresData();
//   var collection = _firebase.collection(collectionName);
//
//   if (!prefs.containsKey(lastWritten)) {
//     prefs.setInt(lastWritten, 0);
//   }
//   for (var row in dataToWrite) {
//     if (row[0] > prefs.get(lastWritten)) {
//       int idData = row[0];
//
//       List<List<dynamic>> ingredientsQuery =
//       await _postgreSQLConnection.query("SELECT * FROM cocktails_ingredients WHERE cocktail_id = $idData");
//       Map<String, int> ingredients = {};
//       for(var ingredientRow in ingredientsQuery){
//         ingredients[ingredientRow[1].toString()] = ingredientRow[2];
//       }
//
//       List<List<dynamic>> toolsQuery =
//       await _postgreSQLConnection.query("SELECT * FROM cocktails_tools WHERE cocktail_id = $idData");
//       Map<String, int> tools = {};
//       for(var toolRow in toolsQuery){
//         tools[toolRow[1].toString()] = 1;
//       }
//
//       List<String> recipeList = row[6].toString().split('\n');
//       recipeList.forEach((element) => element.trim());
//       Map<String, dynamic> cocktailData = {
//         id: idData,
//         degree: row[3],
//         imageSource: row[4],
//         volume: row[5],
//         basis: row[9],
//         group: row[10],
//         'ingredients': ingredients,
//         'tools': tools,
//       };
//
//       var newIngredientDocRef = await collection.add(cocktailData);
//       var localeCollection = newIngredientDocRef.collection(subcollectionName);
//
//       Map<String, dynamic> ingredientLocaleData = {
//         title: row[1],
//         description: row[2],
//         recipe: recipeList,
//       };
//
//       await localeCollection.doc('ru').set(ingredientLocaleData);
//
//       prefs.setInt(lastWritten, int.parse(row[0].toString()));
//
//       print('Cocktail added.');
//     }
//   }
// }
//
// void getData() async {
//   var collection = _firebase.collection(collectionName);
//   var docsSnapshot = await collection.get();
//   print(docsSnapshot.docs.length.toString());
//   // for (var doc in docsSnapshot.docs) {
//   //   print(doc.data().keys.join(', '));
//
//   // print(doc[id]);
//   // print(doc[group]);
//   // print(doc[imageSource]);
//   //
//   // var subcollection = doc.reference.collection(subcollectionName);
//   // var localeDocsSnapshot = await subcollection.get();
//   // var localeDocs = localeDocsSnapshot.docs.where((doc) => doc.id == locale);
//   // var localeDoc = localeDocs.isNotEmpty
//   //     ? localeDocs.first
//   //     : localeDocsSnapshot.docs.where((doc) => doc.id == 'en').first;
//   //
//   // print(localeDoc[title]);
//   // print(localeDoc[description]);
//   //}
// }
//
// void initPref() async{
//   prefs = await SharedPreferences.getInstance();
// }
//
// @override
// void initState() {
//   super.initState();
//   initPref();
//   _firebase = FirebaseFirestore.instance;
//   _postgreSQLConnection = PostgreSQLConnection("10.0.2.2", 5432, "postgres",
//       username: "postgres", password: "14631");
//   locale = Platform.localeName.substring(0, 2);
//   print(locale);
// }
//
// @override
// void dispose() {
//   if (!_postgreSQLConnection.isClosed) {
//     _postgreSQLConnection.close();
//   }
//   super.dispose();
// }
