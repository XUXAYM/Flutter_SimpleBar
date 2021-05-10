abstract class IDataSource<T>{
  bool initDB();
  Map get();
  void set(Map mapEntity);
}