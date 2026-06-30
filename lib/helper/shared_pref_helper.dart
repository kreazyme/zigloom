import 'package:shared_preferences/shared_preferences.dart';

abstract class _Action<T> {
  Future<void> saveData(T value);
  Future<T?> getData();
  Future<void> deleteData();
}

class _Onboarding implements _Action<bool> {
  final String key = 'onboarding';

  @override
  Future<void> deleteData() async {
    await SharedPreferences.getInstance().then((prefs) => prefs.remove(key));
  }

  @override
  Future<bool?> getData() {
    return SharedPreferences.getInstance().then((prefs) => prefs.getBool(key));
  }

  @override
  Future<void> saveData(bool value) {
    return SharedPreferences.getInstance().then(
      (prefs) => prefs.setBool(key, value),
    );
  }
}

//TODO: In startup, it will create all [_Action] instance, we must handle it later
class SharedPrefHelper {
  final onboarding = _Onboarding();
}
