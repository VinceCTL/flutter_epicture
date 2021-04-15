import 'package:flutter/material.dart';
import 'package:flutter_epicturee/components/subComponents/subProfileView/FavoriteCard.dart';
import 'package:flutter_epicturee/components/subComponents/subProfileView/profilHeader.dart';
import 'package:flutter_epicturee/models/BaseAccount.dart';
import 'package:flutter_epicturee/models/GalleryList.dart';
import 'package:flutter_epicturee/services/BaseAccount.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with SingleTickerProviderStateMixin {
  BaseAccount accountBase;
  GalleryList accountImages;
  GalleryList accountFavoritesImages;
  int pubCount;
  TabController tabController;

  _ProfileViewState() {
    Account().getAccountImages().then((GalleryList g) => (setState(() => this.accountImages = g)));
    Account().getAccountBase().then((BaseAccount a) => (setState(() => this.accountBase = a)));
    Account().getAccountPublicationsCount().then((int c) => (setState(() => this.pubCount = c)));
    Account().getGalleryFavorites().then((GalleryList g) => (setState(() => this.accountFavoritesImages = g)));
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    if (this.accountBase == null || this.accountImages == null
        || this.pubCount == null || this.accountFavoritesImages == null) {
      return CircularProgressIndicator();
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            // this.profileHeader(context),
            ProfileHeader(
              accountBase: this.accountBase
            ),
            this.createTabBar(context),
            this.profileAlbum(context)
          ],
        ),
      );
    }
  }


  Widget createTabBar(BuildContext context) {
    return Container(
      child: TabBar(
        controller: this.tabController,
        tabs: <Widget>[
          Tab(
            icon: Icon(
                Icons.favorite,
                color: Colors.lightBlueAccent
            ),
          ),
          Tab(
              icon: Icon(
                  Icons.person,
                  color: Colors.lightBlueAccent
              )
          )
        ],
      ),
    );
  }

  Widget profileAlbum(BuildContext context) {
    return Expanded(
      child: TabBarView(
        controller: this.tabController,
        children: <Widget>[
          Container(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: this.accountFavoritesImages.gallery.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return FavoriteCard(
                    image: this.accountFavoritesImages.gallery[index],
                  );
                }
            ),
          ),
          Container(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: this.accountImages.gallery.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return FavoriteCard(
                    image: this.accountImages.gallery[index],
                  );
                }
            ),
          ),
        ],
      ),
    );
  }

}
