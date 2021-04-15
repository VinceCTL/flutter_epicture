import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epicturee/models/GalleryList.dart';

typedef void searchCallback(String search);
typedef void changeSortOptions(int sort, int window);

// ignore: must_be_immutable
class SearchArea extends StatefulWidget {

  final GalleryList galleryList;
  final searchCallback onValidationString;
  final changeSortOptions onClickChip;


  SearchArea ({this.galleryList, @required this.onValidationString, @required this.onClickChip});

  @override
  _SearchAreaState createState() => _SearchAreaState();
}

class _SearchAreaState extends State<SearchArea> {

  TextEditingController textInputController;
  int currentSortingOption = 0;
  int currentWindowOption = 0;
  List<String> sortOptions = ["time", "viral", "top"];
  List<String> windowOptions = ["all", "day", "week", "month", "year"];
  int my_indexWin = 0;
  int myIndexSort = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            // height: 260,
            alignment: Alignment.topCenter,
            child: TextField(
              controller: this.textInputController,
              decoration: InputDecoration(
                prefixIcon: new Icon(Icons.search, color: Colors.grey),
                hintText: "Search Something ",
                hintStyle: new TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              ),
              onSubmitted: (String search) {
                print(search);
                widget.onValidationString(search);
              },
            ),
          ),
           Container(
             alignment: Alignment.topLeft,
             height: 40,
             // color: Colors.red,
             // padding: EdgeInsets.all(5),
             child: this.sortChipSort(context),
           ),
          Container(
            height: 40,
            alignment: Alignment.topLeft,
            // padding: EdgeInsets.all(5),
            child: this.sortChipWindow(context),
          )
        ],
      ),
    );
  }

  Widget sortChipSort(BuildContext context) {
    return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            // physics: ClampingScrollPhysics(),
            itemCount: this.sortOptions.length,
            itemBuilder: (BuildContext context, int index) {
              return InputChip(
                selected: (index == this.currentSortingOption) ? true : false,
                label: Text(this.sortOptions[index]),
                onPressed: () => this.changeSortOption(index),
              );
            },
    );
  }

  Widget sortChipWindow(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: ClampingScrollPhysics(),
      itemCount: this.windowOptions.length,
      itemBuilder: (BuildContext context, int index) {
        return InputChip(
          selected: (index == this.currentWindowOption) ? true : false,
          label: Text(this.windowOptions[index]),
          onPressed: () => this.changeSortWindow(index),
        );
      },
    );
  }

  void changeSortOption (int index) {
    setState(() {
      this.currentSortingOption = index;
    });
    widget.onClickChip(this.currentSortingOption, this.currentWindowOption);

  }

  void changeSortWindow (index) {
    setState(() {
      this.currentWindowOption = index;
    });
    widget.onClickChip(this.currentSortingOption, this.currentWindowOption);

  }
}
