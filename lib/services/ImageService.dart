import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_epicturee/models/Image.dart';
import 'package:flutter_epicturee/services/BaseImgur.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageService extends BaseImgur {

  Future<Map<String, dynamic>> favoriteImage(GalleryImage image) async {
    var sharedPreferences = await SharedPreferences.getInstance();

    var response = await http.post(
        this.baseUrl + "image/" + image.cover + "/favorite",
        headers: {
          "Authorization": "Bearer " + sharedPreferences.getString("user_access_token")
        }
    );

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      return json;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> uploadImage(Map<String, dynamic> data) async {
    var sharedPreferences = await SharedPreferences.getInstance();

    // Image Form Data is send in base64 format
    List<int> imageBytes = data["image"].readAsBytesSync();
    String base64Image = convert.base64Encode(imageBytes);

    var response = await http.post(
        this.baseUrl + "/upload",
        headers: {
          "Authorization": "Bearer " + sharedPreferences.getString("user_access_token")
        },
        body: {
          "image": base64Image,
          "title": data["title"],
          "description": data["description"]
        }
    );

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      return json["data"];
    } else {
      return null;
    }
  }

}