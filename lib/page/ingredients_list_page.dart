import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/ingredient.dart';
import '../supplemental/ingredient_tile.dart';
import '../provider/ingredients_notifier.dart';
import 'page.dart';

class IngredientListPage extends StatefulWidget with PageWithTitle {
  IngredientListPage({this.title: ''});

  final String title;

  @override
  _IngredientListPageState createState() => _IngredientListPageState();
}

class _IngredientListPageState extends State<IngredientListPage>
    with SingleTickerProviderStateMixin, RestorationMixin {
  TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_scrollable_demo';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  Stream<DocumentSnapshot> getLocaleData(QueryDocumentSnapshot doc) =>
      doc.reference.collection('locale').doc('ru').snapshots();

  @override
  void initState() {
    _tabController = TabController(
      initialIndex: 0,
      length: IngredientGroup.values.length - 1,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
    FirebaseFirestore.instance.settings =
        Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
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
    var ingredientsNotifier = context.watch<IngredientsPoolNotifier>();

    final tabs = IngredientGroup.values.skip(1).toList();

    return Scaffold(
      appBar: TabBar(
        indicatorColor: Theme.of(context).tabBarTheme.labelColor,
        controller: _tabController,
        isScrollable: true,
        tabs: [
          for (final tab in tabs)
            Tab(
                text: tab
                    .toString()
                    .replaceAll('IngredientGroup.', '')
                    .replaceAll('_', ' ')
                    .toUpperCase()),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          for (final tab in tabs) //ingredientsGroupStreamFull
            StreamBuilder<QuerySnapshot>(
              stream: ingredientsNotifier.ingredientsGroupStream(tab),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var docs = snapshot.data.docs;
                  return docs.length > 0
                      ? new ListView.builder(
                          itemCount: docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: StreamBuilder<DocumentSnapshot>(
                                  stream: getLocaleData(docs[index]),
                                  builder: (context, localeDoc) {
                                    if (localeDoc.hasData) {
                                      var ingredientMappedData =
                                          docs[index].data();
                                      ingredientMappedData
                                          .addAll(localeDoc.data.data());
                                      var ingredient = Ingredient.fromMap(
                                          ingredientMappedData);
                                      return IngredientListTile(
                                        ingredient,
                                        subtitle: ingredient.degree > 0
                                            ? "Degree: ${ingredient.degree}"
                                            : '',
                                      );
                                    } else {
                                      return Center();
                                    }
                                  }),
                            );
                          })
                      : Center(child: Text('There are no ingredients now'));
                } else {
                  return Center(child: Text('There are no ingredients now'));
                }
              },
            ),
        ],
      ),
      // body: TabBarView(
      //   controller: _tabController,
      //   children: [
      //     for (final tab in tabs)
      //       StreamBuilder<QuerySnapshot> (
      //         stream: ingredientsNotifier.ingredientsGroupStream(tab),
      //         builder: (context, snapshot) {
      //           if (snapshot.connectionState == ConnectionState.waiting) {
      //             return const Center(child: CircularProgressIndicator());
      //           }
      //
      //           if (snapshot.hasError) {
      //             return Center(child: Text(snapshot.error.toString()));
      //           }
      //           QuerySnapshot querySnapshot = snapshot.data;
      //
      //           List<Ingredient> ingredients = [];
      //           for(var doc in querySnapshot.docs){
      //             var mapData = doc.data();
      //             var ref = doc.reference.collection('locale').doc('ru');
      //           }
      //
      //           return ListView.builder(
      //             itemCount: querySnapshot.size,
      //             itemBuilder: (context, index) => Movie(querySnapshot.docs[index]),
      //           );
      //
      //           return ingredientsNotifier.loadIngredients(tab).length > 0
      //               ? IngredientsList(ingredientsNotifier.loadIngredients(tab))
      //               : Center(child: Text('There is nothing here now'));
      //         },
      //       )
      //   ],
      // ),
    );
  }
}
// StreamBuilder<QuerySnapshot>(
// stream: ingredientsNotifier.ingredientsGroupStream(tab),
// builder: (context, snapshot) {
// if (snapshot.hasData) {
// var doc = snapshot.data.docs;
// return new ListView.builder(
// itemCount: doc.length,
// itemBuilder: (context, index) {
// print(doc[index].id);
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: Card(
// child: Column(
// children: <Widget>[
// Text(doc[index].data()['id'].toString()),
// SizedBox(
// height: 10.0,
// ),
// Text(doc[index].data()['group']),
// SizedBox(
// height: 10.0,
// ),
// Text(doc[index].data()['measure']),
// SizedBox(
// height: 10.0,
// ),
// Text(doc[index].data()['imageSource']),
// ],
// ),
// ),
// );
// });
// } else {
// return Center(child: CircularProgressIndicator(
// backgroundColor: Colors.lightBlue,
// ));
// }
// },
// ),

// FutureBuilder<List<Ingredient>>(
// future: ingredientsNotifier.ingredientsGroupStreamWithData(tab),
// builder: (context, snapshot) {
// if(snapshot.hasData){
// return snapshot.data.length > 0
// ? IngredientsList(
// snapshot.data)
//     : Center(child: Text('There is nothing here now'));
// }else{
// return Center(
// child: CircularProgressIndicator(
// backgroundColor: Colors.lightBlue,
// ));
// }
// },
// ),
