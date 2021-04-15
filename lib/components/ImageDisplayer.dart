import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epicturee/components/subComponents/ActionImageBar.dart';
import 'package:flutter_epicturee/services/ImageService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_epicturee/models/Image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageDisplayer extends StatefulWidget {
  final GalleryImage image;
  final bool isFromProfilePage;
  // final bool isFromUser;

  ImageDisplayer({
    Key key,
    @required this.image,
    @required this.isFromProfilePage,
    // @required this.isFromUser
  }) : super(key: key);

  @override
  _ImageDisplayerState createState() => _ImageDisplayerState();
}

class _ImageDisplayerState extends State<ImageDisplayer>{
  var sharedPreferences = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    // this.getImage(context, this.widget.image);

    return this.BaseBody(context);
  }

  Widget BaseBody(BuildContext context) {
    // if (!this.widget.isFromProfilePage) {
    //   Card(
    //     clipBehavior: Clip.antiAlias,
    //     elevation: 5,
    //     child: Column(
    //       children: <Widget>[
    //         ListTile(
    //           leading: CircleAvatar(
    //             backgroundImage: NetworkImage(
    //               "https://imgur.com/user/" + this.widget.image.username +
    //                   "/avatar",
    //             ),
    //           ),
    //           title: Text(
    //             this.widget.image.title,
    //           ),
    //           subtitle: Text(
    //             this.widget.image.username,
    //             style: TextStyle(color: Colors.black.withOpacity(0.6)
    //             ),
    //           ),
    //         ),
    //         this.ImageViewer(context),
    //         Container(
    //           child: ActionImageBar(this.widget.image),
    //         ),
    //       ],
    //     ),
    //   );
    // }
    // return Card(
    //     child: SingleChildScrollView(
    //       child: Container(
    //         padding: this.widget.isFromProfilePage ? EdgeInsets.only(top: 50) : 0,
    //         child: Column(
    //           children: <Widget>[
    //             this.ImageViewer(context),
    //             Container(
    //                 padding: EdgeInsets.all(5),
    //                 child: ActionImageBar(this.widget.image)
    //             ),
    //           ],
    //         ),
    //       ),
    //     )
    // );
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://imgur.com/user/" + this.widget.image.username +
                    "/avatar",
              ),
            ),
            title: Text(
              this.widget.image.title != null ? this.widget.image.title : "",
            ),
            subtitle: Text(
              this.widget.image.username != null ? this.widget.image.username : "",
              style: TextStyle(color: Colors.black.withOpacity(0.6)
              ),
            ),
          ),
          this.ImageViewer(context),
          Container(
            child: ActionImageBar(this.widget.image),
          ),
        ],
      ),
    );
  }

  Widget ImageViewer(BuildContext context) {
    // if (!this.widget.isFromProfilePage) {
    //   return Card(
    //     elevation: 7,
    //     child: GestureDetector(
    //       onDoubleTap: () => ImageService().favoriteImage(this.widget.image),
    //       child: Image.network(
    //           "https://i.imgur.com/" +
    //               this.widget.image.cover + "." +
    //               ((this.widget.image.imagesInfo == null) ? "jpg" :
    //               this.widget.image.imagesInfo[0].type.split('/')[1]),
    //         // this.widget.image.imagesInfo[0].link,
    //       ),
    //     ),
    //   );
    // }
    return Card(
      elevation: 7,
      child: Image.network( (this.widget.isFromProfilePage) ?
        "https://i.imgur.com/" +
            this.widget.image.id + "." +
          ((this.widget.image.imagesInfo == null) ? "jpg" :
          this.widget.image.imagesInfo[0].type.split('/')[1]) :
      "https://i.imgur.com/" +
          this.widget.image.cover + "." +
          ((this.widget.image.imagesInfo == null) ? "jpg" :
          this.widget.image.imagesInfo[0].type.split('/')[1]),
      ),
    );

  }


}

