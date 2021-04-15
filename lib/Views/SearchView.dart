import 'package:flutter/material.dart';
import 'package:flutter_epicturee/components/ImageDisplayer.dart';
import 'package:flutter_epicturee/components/subComponents/SubSearchView/SearchArea.dart';
import 'package:flutter_epicturee/models/GalleryList.dart';
import 'package:flutter_epicturee/models/Image.dart';
import 'package:flutter_epicturee/services/Gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  GalleryList galleryList;
  int currentSortingOption = 0;
  int currentWindowOption = 0;
  List<String> sortOptions = ["time", "viral", "top"];
  List<String> windowOptions = ["all", "day", "week", "month", "year"];
  String currentSearch = "Cat";
  bool isLoading = true;
  TextEditingController textInputController;


  Future<void> getData(String search) async {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      Gallery().getGalleryResearch(this.currentSearch,
          this.sortOptions[this.currentSortingOption],
          this.windowOptions[this.currentWindowOption]).then((GalleryList list) {
        setState(() {
          print(this.windowOptions[this.currentWindowOption]);
          print(this.sortOptions[this.currentSortingOption]);
          this.currentSearch = search;
          this.galleryList = list;
          this.galleryList.gallery.removeWhere((i) => (
              (i.imagesInfo != null && i.imagesInfo.length != 0 && i.imagesInfo[0].type.contains('mp4') ||
                  i.imagesInfo != null && i.imagesInfo.length != 0 && i.imagesInfo[0].type.contains('gif'))
                  || (i.cover == null)
          ));
          this.isLoading = false;
        });
      });
    });
  }

  _SearchViewState() {
    this.getData(this.currentSearch,);
  }

  void changeSortOptions(int sort, int window) {
    setState(() {
      this.isLoading = true;
      this.currentSortingOption = sort;
      this.currentWindowOption = window;
    });
    this.getData(this.currentSearch);
  }

  @override
  void dispose() {
    textInputController.dispose();
    super.dispose();
  }

    @override
    void initState() {
      this.textInputController = TextEditingController();
      super.initState();
    }


    Widget gridImage(BuildContext context) {
      return Flexible(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3
            ),
            itemCount: this.galleryList.gallery.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return gridGetImage(this.galleryList.gallery[index]);
            }
        )
      );
    }

    Widget gridGetImage(GalleryImage image) {
      return Container(
        child: Card(
          elevation: 5,
          semanticContainer: true,
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ImageDisplayer(image: image, isFromProfilePage: false)),
            ),
            child: GridTile(
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            image.imagesInfo[0].link,
                        )
                    )
                ),
              ),
            ),
          ),
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      if (galleryList == null) {
        return CircularProgressIndicator();
      }
      return Container(
        child: Column(
          children: <Widget>[
            SearchArea(
              onValidationString: this.getData,
              galleryList: this.galleryList,
              onClickChip: this.changeSortOptions,
            ),
            this.gridImage(context),
          ],
        ),
      );
    }


}
