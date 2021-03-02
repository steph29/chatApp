import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:chatapp/models/firebaseHelper.dart';
import 'package:chatapp/models/user.dart';

class ZoneDeTexteWidget extends StatefulWidget{
User partenaire;
String id;

ZoneDeTexteWidget(User partenaire, String id){
	this.partenaire = partenaire;
	this.id = id;
}

	ZoneState createState() => new ZoneState();

}

class ZoneState extends State<ZoneDeTexteWidget>{

	TextEditingController _textEditingController = new TextEditingController();
	User moi;
	@override
	void initState() {
    // TODO: implement initState
    FirebaseHelper().getUser(widget.id).then((user) {
   setState(() {
     moi = user;
   });
    });
  }
	 @override
	Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
	    color: Colors.grey[300],
	    padding: EdgeInsets.all(15.0),
	    child: new Row(
		    children: <Widget>[
		  new IconButton(icon: new Icon(Icons.camera_enhance), onPressed: () => takePicture(ImageSource.camera)),
			 new IconButton(icon: new Icon(Icons.photo_library), onPressed: () => takePicture(ImageSource.gallery)),
			    new Flexible(
					    child: new TextField(
						    controller: _textEditingController,
						    decoration: InputDecoration.collapsed(hintText: "Écrivez votre message"),
						    maxLines: null,
					    ),
			    ),
			    new IconButton(icon: new Icon(Icons.send ), onPressed: _sendButtonPressed)
		    ],
	    ),
    );
  }
_sendButtonPressed(){
	 	if(_textEditingController.text != null && _textEditingController.text != "") {
	 		String text = _textEditingController.text;
	 		FirebaseHelper().sendMessage(widget.partenaire, moi, text, null);
	 		_textEditingController.clear();
	 		FocusScope.of(context).requestFocus(new FocusNode());
	  }
	 	else{
	 		print("text vide ou null");
	  }
}
Future<void> takePicture(ImageSource source) async {
		File file = await ImagePicker.pickImage(source: source, maxWidth: 1000.0, maxHeight: 1000.0);
		String date = new DateTime.now().millisecondsSinceEpoch.toString();
		FirebaseHelper().savePicture(file, FirebaseHelper().storage_message.child(widget.id).child(date)).then((string) {
			FirebaseHelper().sendMessage(widget.partenaire, moi, null, string);
		});

	}
}