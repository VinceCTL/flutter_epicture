import 'package:flutter/material.dart';
import 'package:flutter_epicturee/Views/HomeView.dart';
import 'package:flutter_epicturee/Views/LoginView.dart';
import 'package:flutter_epicturee/Views/ProfileView.dart';
import 'package:flutter_epicturee/Views/SearchView.dart';
import 'package:flutter_epicturee/components/subComponents/subNavigationBar/ImageUploader.dart';


class NavigationMenuWidget extends StatefulWidget {

  bool byPassLogin = false;

  NavigationMenuWidget({Key key, this.byPassLogin}) : super(key: key);

  @override
  _NavigationMenuWidgetState createState() => _NavigationMenuWidgetState();
}

class _NavigationMenuWidgetState extends State<NavigationMenuWidget> {
  int selectedItem = 0;
  List<String> itemNames = ["Epicture", "Search", "Profile"];

  List<Widget> widgetOptions = <Widget>[
    HomeView(),
    SearchView(),
    ProfileView(),
    /**/
  ];
  bool loggedOut = false;

  void onTappedItem(int index) {
    setState(() {
      this.selectedItem = index;
    });
  }

  Widget baseMenu(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(40),
      child: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(itemNames[selectedItem]),
      ),
    );
  }

  Widget profileMenu(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(40),
      child: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(itemNames[selectedItem]),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.forward, color: Colors.white, semanticLabel: "exit",),
              onPressed: () {
                setState(() {
                  this.loggedOut = true;
                });
              }
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.loggedOut == true && this.widget.byPassLogin == false) {
      return LoginView();
    }
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      resizeToAvoidBottomInset: false,
      appBar: (this.selectedItem == 2) ? this.profileMenu(context) : this.baseMenu(context),
      body: Center(
        child: widgetOptions.elementAt(this.selectedItem),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: this.selectedItem,
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.grey.shade700,
        onTap: onTappedItem,
      ),
      floatingActionButton: ImageUpdater(),
    );
  }

}