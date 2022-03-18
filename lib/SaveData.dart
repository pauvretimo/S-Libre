import 'package:shared_preferences/shared_preferences.dart';

class SaveSettings {
  void save(String id, param) async {
    final prefs = await SharedPreferences.getInstance();
    if (param.runtimeType == int) {
      await prefs.setInt(id, param);
    } else if (param.runtimeType == bool) {
      await prefs.setBool(id, param);
    } else if (param.runtimeType == double) {
      await prefs.setDouble(id, param);
    } else if (param.runtimeType == String) {
      await prefs.setString(id, param);
    } else if (param.runtimeType == List<String>) {
      await prefs.setStringList(id, param);
    }
  }

  void saveMultiple(List<String> ids, List param) async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < ids.length; i++) {
      if (param[i].runtimeType == int) {
        await prefs.setInt(ids[i], param[i]);
      } else if (param[i].runtimeType == bool) {
        await prefs.setBool(ids[i], param[i]);
      } else if (param[i].runtimeType == double) {
        await prefs.setDouble(ids[i], param[i]);
      } else if (param[i].runtimeType == String) {
        await prefs.setString(ids[i], param[i]);
      } else if (param[i].runtimeType == List<String>) {
        await prefs.setStringList(ids[i], param[i]);
      }
    }
  }

  Future<Object?> read(String id) async {
    final prefs = await SharedPreferences.getInstance();
    Object? r = await prefs.get(id);
    return r;
  }

  Future<int?> readInt(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(id);
  }

  Future<bool?> readbool(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(id);
  }

  Future<double?> readDouble(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(id);
  }

  Future<String?> readString(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(id);
  }

  Future<List<String>?> readStringList(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(id);
  }

  Future<Object?> readMultiple(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    List<Object?> acc = [];
    for (int i = 0; i < ids.length; i++) {
      acc.add(prefs.get(ids[i]));
    }
    return acc;
  }
}

SaveSettings saveSettings = SaveSettings();
