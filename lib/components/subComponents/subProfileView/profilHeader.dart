import 'package:flutter/material.dart';
import 'package:flutter_epicturee/models/BaseAccount.dart';

class ProfileHeader extends StatefulWidget {

  BaseAccount accountBase;

  ProfileHeader({@required this.accountBase});

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://imgur.com/user/Castl13/cover?maxwidth=2560"),
                      fit: BoxFit.fill,
                    )
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            this.profilePicture(context),
                          ],
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        (this.widget.accountBase.bio == null) ? "Aucune biographie" : this.widget.accountBase.bio,
                        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12, color: Colors.white70),
                      ),
                    )
                  ],
                )
            )
        )
    );
  }

  Widget profilePicture(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage("https://imgur.com/user/" + this.widget.accountBase.name + "/avatar")
                    )
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              (this.widget.accountBase.name) != null ? this.widget.accountBase.name : "noName",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: Colors.white70,
              ),
            ),
          )
        ],
      ),
    );
  }
}
