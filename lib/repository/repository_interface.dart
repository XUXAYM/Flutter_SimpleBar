
abstract class IRepository<T>{
  Future<Iterable<T>> getAll(); // получение всех объектов
  T get(int id); // получение одного объекта по id
  void create(T item); // создание объекта
  void update(T item); // обновление объекта
  void delete(int id); // удаление объекта по id
  void save();
}