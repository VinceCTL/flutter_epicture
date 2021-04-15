import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_epicturee/services/ImageService.dart';

class UploaderView extends StatefulWidget {
  final File imageData;

  UploaderView({@required this.imageData});

  @override
  _UploaderViewState createState() => _UploaderViewState();
}

class _UploaderViewState extends State<UploaderView> with SingleTickerProviderStateMixin {

  bool isUploading = false;
  Animation<double> isAnimated;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2)
    )..addListener(() => null);
    isAnimated = Tween<double>(
        begin: 20,
        end: 25
    ).animate(animationController);

    animationController.forward();

    isAnimated.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.repeat();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.imageData == null) {
      Navigator.pop(context);
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
            backgroundColor: Colors.lightBlueAccent,
            title: Text("Upload")
        ),
      ),
      body: createView(context),
    );
  }

  Widget createView(BuildContext context) {
    if (this.isUploading == false) {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            imageToUpload(context),
            imageUploadInformation(context)
          ],
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(25),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Image.file(
                    this.widget.imageData,
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 2 - 20,
                top: MediaQuery.of(context).size.height / 2 - 180,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
              child: AnimatedDefaultTextStyle(
                child: Text("Image is uploading..."),
                duration: Duration(milliseconds: 200),
                style: (this.isAnimated.value >= 22) ? TextStyle(
                    fontSize: this.isAnimated.value,
                    color: Colors.lightBlueAccent
                ) : TextStyle(
                    fontSize: this.isAnimated.value,
                    color: Colors.blueAccent
                ),
              )
          )
        ],
      );
    }
  }

  Widget imageUploadInformation(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Title",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: "Description",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(),
                  )
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: IconButton(
                    icon: Icon(Icons.add_circle, size: 50, color: Colors.lightBlueAccent),
                    onPressed: () {
                      setState(() {
                        this.isUploading = true;
                      });
                      ImageService().uploadImage({
                        "image": this.widget.imageData,
                        "title": "",
                        "description": ""
                      }).then((Map<String, dynamic> json) {
                        setState(() {
                          this.isUploading = false;
                        });
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.cancel, size: 50, color: Colors.redAccent),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget imageToUpload(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 7,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        child: Image.file(
          this.widget.imageData,
        ),
      ),
    );
  }


}
