import 'package:chatapp/models/firebaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/models/user.dart';
import 'package:chatapp/widget/customImage.dart';
import 'package:chatapp/widget/zoneDeTextWidget.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/widget/chatBubble.dart';

class ChatController extends StatefulWidget {
	String id;
	User partenaire;


	ChatController(String id, User partenaire){
		this.id = id ;
		this.partenaire = partenaire;
	}

	ChatControllerState createState() => new ChatControllerState();
}

class ChatControllerState extends State<ChatController> {
	@override
	Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
	    child: new Scaffold(
		    appBar: new AppBar(title: new Row(
			    mainAxisAlignment: MainAxisAlignment.center,
			    children: <Widget>[
			    	new CustomImage(widget.partenaire.imageUrl, widget.partenaire.imageUrl, 15.0),
				    new Text(widget.partenaire.prenom),
			    ],
		    ),
		    ),
		    body: new Container(
			    child: new InkWell(
				    onTap: () => {
				    	FocusScope.of(context).requestFocus(new FocusNode()),
				    },
				    child: new Column(
					    children: <Widget>[
					    	// Zone de chat
						    new Flexible(child: new FirebaseAnimatedList(
								    query: FirebaseHelper().base_message.child(FirebaseHelper().getMessage(widget.id, widget.partenaire.id)),
								    sort: (a, b) => b.key.compareTo(a.key) ,
								    reverse: true,
								    itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index ){
								    	Message message = new Message(snapshot);
								    print(message.text);
								    return new ChatBubble(message, widget.id, widget.partenaire , animation);
								    })
						    ),
						    new Divider(height: 1.5,),
						    new ZoneDeTexteWidget(widget.partenaire, widget.id),
						    //divider
					    ],
				    ),
			    ),
		    ),
	    ),
    );
  }
}