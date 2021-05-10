import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/ingredient.dart';
import 'repository_interface.dart';

class IngredientRepository implements IRepository<Ingredient> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String langCode = 'en';
  String collectionName = 'ingredient';
  String subCollectionName = 'locale';

  @override
  Future<Iterable<Ingredient>> getAll() async{
    throw UnimplementedError();
  }

  @override
  Ingredient get(int id) {
    throw UnimplementedError();
  }

  @override
  void create(Ingredient item) {
    throw UnimplementedError();
  }

  @override
  void update(Ingredient item) {
    throw UnimplementedError();
  }

  @override
  void delete(int id) {
    throw UnimplementedError();
  }

  @override
  void save() {
    throw Exception('not implemented');
  }
}
