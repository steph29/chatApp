import 'package:flutter/material.dart';
import 'package:chatapp/models/message.dart';
import 'package:chatapp/models/user.dart';
import 'package:chatapp/widget/customImage.dart';

class ChatBubble extends StatelessWidget {
	Message message;
	User partenaire;
	String monId;
	Animation animation;

	ChatBubble(Message message, String id, User partenaire, Animation animation){
		this.message = message;
		this.partenaire = partenaire;
		this.monId = id;
		this.animation = animation;
	}
	@override
	Widget build(BuildContext context) {
    // TODO: implement build
    return new SizeTransition(
		    sizeFactor: new CurvedAnimation(parent: animation, curve: Curves.easeIn),
        child: new Container(
	        margin: EdgeInsets.all(10.0),
	        child: new Row(
		        crossAxisAlignment: CrossAxisAlignment.end,
		        children: widgetsBubble(message.from == monId),
	        ),
        ),
    );
  }

  List<Widget> widgetsBubble (bool moi) {
		CrossAxisAlignment alignment = (moi) ? CrossAxisAlignment.end : CrossAxisAlignment.start;
		Color bubbleColor = (moi) ? Colors.blue[400] : Colors.grey[300];
		Color textColor = (moi) ? Colors.black : Colors.grey[700];
		return <Widget>[
			moi ? new Padding(padding: EdgeInsets.all(8.0)) :  new CustomImage(partenaire.imageUrl, partenaire.initiales, 15.0),
			new Expanded(
				child: new Column(
					crossAxisAlignment: alignment,
					children: <Widget>[
						new Text(message.dateString),
						new Card(
							elevation: 5.0,
							shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
							color: bubbleColor,
							child: new Container(
								padding: EdgeInsets.all(10.0),
								child: (message.imageUrl == null)
										? new Text(message.text ?? "",
																style: new TextStyle(color: textColor, fontSize: 15.0, fontStyle: FontStyle.italic),)
										: new CustomImage(message.imageUrl, null, null) ,
							),
						),
					],
				),
			)
		];
  }
 }