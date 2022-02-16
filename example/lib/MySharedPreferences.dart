import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences{
  late SharedPreferences _preferences;

  void clearAll()async{
    _preferences = await SharedPreferences.getInstance();
    bool clear = await _preferences.clear();
  }

  void addApiToken(String apiToken)async{
    _preferences = await SharedPreferences.getInstance();
    _preferences.setString("apiToken", apiToken);
  }

  Future<String> getApiToken()async{
    _preferences = await SharedPreferences.getInstance();
    late String token;
    if(_preferences.containsKey("apiToken")) {
      token =  _preferences.getString("apiToken") ?? "";
    }
    else token = "";
    return token;
  }

  void addCurrentNewClient(String clientId)async{
    _preferences = await SharedPreferences.getInstance();
    _preferences.setString("currentClientId", clientId);
  }

  Future<String> getCurrentClient()async{
    _preferences = await SharedPreferences.getInstance();
    late String token;
    if(_preferences.containsKey("currentClientId")) {
      token =  _preferences.getString("currentClientId") ?? "";
    }
    else token = "";
    return token;
  }

  void addErrorData(String errorData)async{
    _preferences = await SharedPreferences.getInstance();
    _preferences.setString("errorData", errorData);
  }

  Future<String> getErrorData()async{
    _preferences = await SharedPreferences.getInstance();
    late String token;
    if(_preferences.containsKey("errorData")) {
      token =  _preferences.getString("errorData") ?? "";
    }
    else token = "";
    return token;
  }

  void addUserData(String jsonString)async{
    _preferences = await SharedPreferences.getInstance();
    _preferences.setString("userData", jsonString);
  }

  Future<String> getUserData()async{
    _preferences = await SharedPreferences.getInstance();
    late String userData;
    if(_preferences.containsKey("userData")) {
      userData =  _preferences.getString("userData") ?? "";
    }
    return userData;
  }
}