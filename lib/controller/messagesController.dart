import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:chatapp/models/firebaseHelper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:chatapp/models/conversation.dart';
import 'package:chatapp/widget/customImage.dart';
import 'package:chatapp/controller/chatController.dart';

class MessagesController extends StatefulWidget{
	String id;
	MessagesController(String id){
		this.id = id;
	}
	MessagesControllerState createState() => MessagesControllerState();
}

class MessagesControllerState extends State<MessagesController>{
	@override
	Widget build(BuildContext context) {
    // TODO: implement build
    return new FirebaseAnimatedList(
		    query: FirebaseHelper().base_conversation.child(widget.id),
		    sort: (a,b) => b.value["dateString"].compareTo(a.value["dateString"]),
		    itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
		    	Conversation conversation = new Conversation(snapshot);
		    	String subTitle = (conversation.id == widget.id) ? " Moi: " : "";
		    	subTitle += conversation.last_message ?? "image envoyé";
		    	return new ListTile(
				    leading: new CustomImage(conversation.user.imageUrl, conversation.user.initiales, 20.0),
				    title: new Text("${conversation.user.prenom}  ${conversation.user.nom}"),
				    subtitle: new Text(subTitle),
				    trailing: new Text(conversation.date),
				    onTap: (){
				    	Navigator.push(context, new MaterialPageRoute(builder: (context) => new ChatController(widget.id, conversation.user )));
				    },
			    );
		    });
  }
}