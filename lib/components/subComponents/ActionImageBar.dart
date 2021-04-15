import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epicturee/models/Image.dart';
import 'package:flutter_epicturee/services/ImageService.dart';

class ActionImageBar extends StatefulWidget {

  final GalleryImage image;

 ActionImageBar (this.image);

  @override
  _ActionImageBarState createState() => _ActionImageBarState();
}

class _ActionImageBarState extends State<ActionImageBar> {

  var iconState = Icon(Icons.favorite_border);

  @override
  Widget build(BuildContext context) {
    if (this.widget.image.isFavorite) {
      setState(() {
        this.iconState = Icon(Icons.favorite, color: Colors.red,);
      });
    }

    return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              this.likeImage(),
              this.dislikeImage(),
              SizedBox(width: 15,),
              this.favoriteImage(),
              this.viewsCounter(),
            ],
          ),
        );
  }

  Widget favoriteImage() {
      return Container(
        // padding: EdgeInsets.all(5),
        child: GestureDetector(
          onTap: () {
            ImageService().favoriteImage(this.widget.image);
            setState(() {
              this.iconState = Icon(Icons.favorite, color: Colors.red,);
            });
          },
          child: IconButton(
            icon: this.iconState,
          ),
        ),
      );
  }

  Widget likeImage() {
    return Container (
      // padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.thumb_up,
            color: Colors.blueAccent,
          ),
          Text(this.widget.image.ups.toString()),
        ],
      ),
    );
  }

  Widget dislikeImage() {
    return Container (
      // padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.thumb_down,
            color: Colors.red,
          ),
          Text(this.widget.image.downs.toString()),
        ],
      ),
    );
  }

  Widget viewsCounter() {
    return Container(
        // padding: EdgeInsets.only(left: 10.0),
        child: Text(
          "Views : " + this.widget.image.views.toString(),
          style: TextStyle(fontWeight: FontWeight.bold),
        )
    );
  }


}
