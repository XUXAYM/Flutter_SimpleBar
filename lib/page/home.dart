import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/cocktail.dart';
import '../supplemental/cocktail_card.dart';
import '../provider/cocktails_notifier.dart';
import 'page.dart';

class CocktailsListPage extends StatelessWidget with PageWithTitle {
  CocktailsListPage({this.title: ''});

  final String title;

  Stream<DocumentSnapshot> getLocaleData(QueryDocumentSnapshot doc) =>
      doc.reference.collection('locale').doc('ru').snapshots();

  @override
  Widget build(BuildContext context) {
    var cocktailsNotifier = context.watch<CocktailsPoolNotifier>();

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream:
              cocktailsNotifier.cocktailsGroupStream(cocktailsNotifier.group),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var docs = snapshot.data.docs;
              return docs.length > 0
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 16,
                      ),
                      physics: BouncingScrollPhysics(),
                      controller: ScrollController(),
                      padding: EdgeInsets.all(16.0),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: getLocaleData(docs[index]),
                              builder: (context, localeDoc) {
                                if (localeDoc.hasData) {
                                  var cocktailMappedData = docs[index].data();
                                  cocktailMappedData['tools'] =
                                      HashMap<int, int>.from(
                                          (cocktailMappedData['tools'] as Map)
                                              .map<int, int>((key, value) =>
                                                  MapEntry(
                                                      int.parse(key), value)));
                                  cocktailMappedData['ingredients'] =
                                      HashMap<int, int>.from(
                                          (cocktailMappedData['ingredients']
                                                  as Map)
                                              .map<int, int>((key, value) =>
                                                  MapEntry(
                                                      int.parse(key), value)));
                                  cocktailMappedData
                                      .addAll(localeDoc.data.data());
                                  return CocktailCard(
                                      Cocktail.fromMap(cocktailMappedData));
                                } else {
                                  return Card(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.lightBlue,
                                      ),
                                    ),
                                  );
                                }
                              }),
                        );
                      })
                  : Center(child: Text('There are no cocktails now'));
            } else {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlue,
              ));
            }
          },
        ),
        // child: CocktailsList(
        //   cocktailsNotifier.loadCocktails(cocktailsNotifier.group),
      ),
    );
  }
}
