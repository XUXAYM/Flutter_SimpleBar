import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../model/ingredient.dart';
import '../repository/ingredient_repository.dart';

String langCode = 'en';
String collectionName = 'ingredient';
String subCollectionName = 'locale';

class IngredientsPoolNotifier with ChangeNotifier {
  IngredientRepository _repository;

  final collection = FirebaseFirestore.instance.collection(collectionName);

  //final List<Ingredient> _ingredients = IngredientsRepository.loadIngredients();
  List<Ingredient> _ingredients = [];

  IngredientsPoolNotifier() {
    _repository = IngredientRepository();
    //init();
  }

  void init() async {
    await _repository.getAll().then((iterable) {
      _ingredients.addAll(iterable);
      print('INGREDIENTS LOADED');
      notifyListeners();
    });
  }

  Stream<QuerySnapshot> ingredientsGroupStream(IngredientGroup group) {
    Query query = collection.where('group', isEqualTo: describeEnum(group));
    return query.snapshots();
  }

  // Stream<Iterable<Map<String, dynamic>>> ingredientsGroupStreamFull(
  //     IngredientGroup group) {
  //   Query query = collection.where('group', isEqualTo: describeEnum(group));
  //   var queryStream = query.snapshots().map((snapshot) => snapshot.docs);
  //   var data = queryStream.map((docSnapshot) => docSnapshot.map((doc) {
  //         var mappedData = doc.data();
  //         var localeSnapshot =
  //             doc.reference.collection('locale').doc('ru').snapshots();
  //         localeSnapshot.map((localeDoc) {
  //           mappedData.addAll(localeDoc.data());
  //           print(localeDoc.data()['title']);
  //         });
  //         return mappedData;
  //       }));
  //
  //   return data;
  // }

  List<Ingredient> loadIngredients(IngredientGroup group) =>
      group == IngredientGroup.all
          ? _ingredients
          : _ingredients.where((Ingredient i) => i.group == group).toList();


  Future<Ingredient> getFutureById(int id) async{
    var snapshot = await collection.where('id', isEqualTo: id).get();
    var doc = snapshot.docs[0];
    var mappedIngredientData = doc.data();
    var localeDataSnapshot = doc.reference.collection('locale').doc('ru');
    var localeData = await localeDataSnapshot.get();
    mappedIngredientData.addAll( localeData.data());
    return Ingredient.fromMap(mappedIngredientData);
  }

  // Ingredient getById(int id) =>
  //     _ingredients.firstWhere((i) => i.id == id, orElse: () => null);
  //
  // Ingredient getByPosition(int index) =>
  //     (index < _ingredients.length && index >= 0) ? _ingredients[index] : null;
}
