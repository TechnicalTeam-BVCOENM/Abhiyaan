import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocalStorageService {
  final GetStorage storage = GetStorage();
  Future<bool> initStorage() async => await GetStorage.init();

  Future<void> write(String key, dynamic value) => storage.write(key, value);

  T? read<T>(String key) => storage.read<T>(key);

  Future<void> delete(String key) =>
      storage.remove(key); //removes the value associated with the key

  Future<void> clear() => storage.erase(); //removes the current container
}
