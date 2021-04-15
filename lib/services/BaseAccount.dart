import 'package:flutter_epicturee/models/BaseAccount.dart';
import 'package:flutter_epicturee/models/GalleryList.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'BaseImgur.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Account extends BaseImgur {

  Future<BaseAccount> getAccountBase() async {
    var sharedPreferences = await SharedPreferences.getInstance();

    var response = await http.get(
        this.baseUrl + "/account/" + sharedPreferences.getString("user_account_name"),
        headers: {
          "Authorization": "Client-ID " + sharedPreferences.getString("account_id")
        }
    );

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      return BaseAccount.fromJson(json["data"]);
    } else {
      return null;
    }
  }

  Future<GalleryList> getAccountImages() async {
    var sharedPreferences = await SharedPreferences.getInstance();

    var response = await http.get(
        this.baseUrl + "/account/me/images",
        headers: {
          "Authorization": "Bearer " + sharedPreferences.getString("user_access_token")
        }
    );

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      return GalleryList.fromJson(json);
    } else {
      return null;
    }
  }

  Future<int> getAccountPublicationsCount() async {
    var sharedPreferences = await SharedPreferences.getInstance();

    var response = await http.get(
        this.baseUrl + "/account/" + sharedPreferences.getString("user_account_name") + "/images/count",
        headers: {
          "Authorization": "Bearer " + sharedPreferences.getString("user_access_token")
        }
    );

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      return json["data"];
    } else {
      return null;
    }
  }


  Future<GalleryList> getGalleryFavorites() async {
    var sharedPreferences = await SharedPreferences.getInstance();

    var response = await http.get(
        this.baseUrl + "/account/" + sharedPreferences.getString("user_account_name")
            + "/favorites",
        headers: {
          "Authorization": "Bearer " + sharedPreferences.getString("user_access_token")
        }
    );

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      return GalleryList.fromJson(json);
    } else {
      return null;
    }
  }

  Future<void> logout() async {
    var sharedPreferences = await SharedPreferences.getInstance();

    return await http.post(
        this.baseImgurUrl + "/logout?client_id=" + sharedPreferences.getString("account_id")
    );
    ;
  }
}