import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class FirestoreDataSource {
  FirebaseFirestore _firestore;
  String langCode = 'en';
  String collectionName;
  String subCollectionName = 'locale';

  FirestoreDataSource(this.collectionName,
      {@required this.langCode});

  bool isInit() => _firestore != null;

  bool initDB() {
    if (isInit()) return true;

    try {
      _firestore = FirebaseFirestore.instance;
      return true;
    } catch (ex) {
      print(ex);
      return false;
    }
  }

  Future<List<Map>> get() async {
    List<Map> mappedEntities = [];

    var stream = _firestore.collection(collectionName).snapshots();

    await for (var snapshot in stream) {
      for (var doc in snapshot.docs) {
        var entityData = doc.data();

        try {
          var subCollection = doc.reference.collection(subCollectionName);
          var localeDocsSnapshot = await subCollection.get();

          var localeDocs = localeDocsSnapshot.docs.where((doc) => doc.id == 'ru');
          var localeDoc = localeDocs.isNotEmpty
              ? localeDocs.first
              : localeDocsSnapshot.docs
              .where((doc) => doc.id == 'ru')
              .first;

          entityData.addAll(localeDoc.data());
        }
        catch(ex){
          print(ex);
        }
        mappedEntities.add(entityData);
      }
    }

    return mappedEntities;
  }

  Future<List<Map>> getByGroup() async {
    List<Map> mappedEntities = [];

    var stream = _firestore.collection(collectionName).snapshots();

    await for (var snapshot in stream) {
      for (var doc in snapshot.docs.where((element) => element.data()['group'])) {
        var entityData = doc.data();

        try {
          var subCollection = doc.reference.collection(subCollectionName);
          var localeDocsSnapshot = await subCollection.get();

          var localeDocs = localeDocsSnapshot.docs.where((doc) => doc.id == 'ru');
          var localeDoc = localeDocs.isNotEmpty
              ? localeDocs.first
              : localeDocsSnapshot.docs
              .where((doc) => doc.id == 'ru')
              .first;

          entityData.addAll(localeDoc.data());
        }
        catch(ex){
          print(ex);
        }
        mappedEntities.add(entityData);
      }
    }

    return mappedEntities;
  }

  bool set(Map mapEntity) {
    throw UnimplementedError();
  }
}
