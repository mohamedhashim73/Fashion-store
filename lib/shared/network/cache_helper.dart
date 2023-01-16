import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedPreference;

  static cacheInitialization() async {
    sharedPreference = await SharedPreferences.getInstance();   // assignment for object sharedPreferences
  }

  // this method for saving any data with any dataType , bool for return to make sure that operation done
  static Future<bool?> saveCacheData({required String key,required dynamic value}) async{
    if( value is int )
    {
      return await sharedPreference?.setInt(key, value);
    }
    else if( value is String )
    {
      return await sharedPreference?.setString(key, value);
    }
    else if( value is bool )
    {
      return await sharedPreference?.setBool(key, value);
    }
    else
    {
      return await sharedPreference?.setDouble(key, value);
    }
  }

  // this method for getting data from shared-pref for any dataType
  static dynamic getCacheData(String key){
    return sharedPreference?.get(key);     // I don't know the dataType for value
  }

  static Future<bool> deleteCacheItem() async {
    await sharedPreference?.clear().then((value){
      if( value == true )
      {
        return true;
      }
      else
      {
        return false;
      }
    });
    return false;
  }

}