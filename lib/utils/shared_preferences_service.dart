import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  // Instância do SharedPreferences
  static SharedPreferences? _prefs;

  // Inicializa o SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Método para salvar uma string no SharedPreferences
  static Future<void> saveString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  // Método para recuperar uma string do SharedPreferences
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Método para remover uma chave do SharedPreferences
  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  // Método para verificar se uma chave existe no SharedPreferences
  static bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }
}
