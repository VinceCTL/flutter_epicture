import 'package:flutter/material.dart';
import 'package:flutter_epicturee/components/ImageDisplayer.dart';
import 'package:flutter_epicturee/models/GalleryList.dart';
import 'package:flutter_epicturee/models/Image.dart';

class FavoriteCard extends StatefulWidget {
  GalleryList accountFavoritesImages;
  GalleryList accountImages;
  GalleryImage image;

  FavoriteCard({@required this.image});

  @override
  _FavoriteCardState createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        semanticContainer: true,
        elevation: 7,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ImageDisplayer(
                image: this.widget.image,
                isFromProfilePage: true,
              )
              )
            );
          },
          child: GridTile(
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://i.imgur.com/" + this.widget.image.id + "." +
                            ((this.widget.image.imagesInfo == null) ? "jpg": this.widget.image.imagesInfo[0].type.split('/')[1])
                      )
                  )
              ),
            ),
          ),
        ),
      )
    );
  }
}
