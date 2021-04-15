import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epicturee/components/ImageDisplayer.dart';
import 'package:flutter_epicturee/models/GalleryList.dart';
import 'package:flutter_epicturee/services/Gallery.dart';

class HomeView extends StatefulWidget {
  HomeView({
    Key key,
  }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GalleryList galleryList;
  bool loading;

  final favoriteNotTriggered = Icon(
    Icons.favorite_border,
    color: Colors.blueAccent,
  );
  final favoriteTriggered = Icon(Icons.favorite, color: Colors.redAccent);

  _HomeViewState() {
    this.loading = true;
    this.getData();
    this.loading = false;
  }


  @override
  Widget build(BuildContext context) {

    return this.galleryList != null && !this.loading ? RefreshIndicator(
      onRefresh: this.getData,
      child: ListView.builder(
        itemCount: this.galleryList.gallery.length,
        itemBuilder: (BuildContext context, int index) {
          return ImageDisplayer(image: this.galleryList.gallery[index], isFromProfilePage: false);
        },
      ),
    ) : CircularProgressIndicator();
    // return Scaffold();
  }


  Future<void> getData() async {
    print("son pere grand");
    Gallery().getGallery({
      "section": "hot",
      "sort": "viral",
      "page": "1",
      "window": "day"
    }, {
      "showViral": true,
      "showMature": false,
      "albumPreviews": false
    }).then((GalleryList list) {
      if (!mounted)
        return;
      setState(() {
        this.galleryList = list;
        // Sort files to keep only images
        this.galleryList.gallery.removeWhere((i) => ((i.imagesInfo != null &&
            i.imagesInfo.length != 0 &&
            i.imagesInfo[0].type.contains('mp4')) ||
            (i.cover == null)));
        this.loading = false;
      });
      print("T A I L L E : ");
      print(this.galleryList);
      print(this.galleryList.gallery[0].link);
      print(this.galleryList.gallery[0].imagesInfo[0].link);
      // print(this.galleryList.gallery[1].id);
      // print(this.galleryList.gallery[1].cover);
    });
  }

}