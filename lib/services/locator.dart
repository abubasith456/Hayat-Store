import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/services/permission/permission.dart';
import 'package:shop_app/services/shared_preferences/shared_pref.dart';

GetIt getIt = GetIt.instance;

@pragma('vm:prefer-inline')
T sl<T extends Object>() => getIt.get<T>();

@pragma('vm:prefer-inline')
Future<T> slAsync<T extends Object>() async => getIt.getAsync<T>();

setLocator() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  getIt.registerLazySingleton(
    () => SharedPrefService(sharedPreferences: sharedPreferences),
  );
  getIt.registerLazySingleton<PermissionService>(
    () => PermissionServiceImpl(),
  );
}
