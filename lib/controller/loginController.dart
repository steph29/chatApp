import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:chatapp/models/firebaseHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends StatefulWidget{
	LoginControllerState createState() => new LoginControllerState();
}

class LoginControllerState extends State<LoginController>{
bool _log = true;
String _mail;
String _password;
String _prenom;
String _nom;


	@override
Widget build(BuildContext context) {
		return new Scaffold(
			appBar: new AppBar(
				title: new Text("Authentification"),
			),
		body: new SingleChildScrollView(
			child: new Column(
				children: <Widget>[
					new Container(
						margin: EdgeInsets.all(20.0),
						width: MediaQuery.of(context).size.width - 40,
						height: MediaQuery.of(context).size.height /2,
						child: new Card(
							elevation: 8.5,
							child: new Container(
								margin: EdgeInsets.only(left: 5.0, right: 5.0),
								child: new Column(
									mainAxisAlignment: MainAxisAlignment.spaceEvenly,
									children: cardElements(),
								),
							),
						),
					),
					new RaisedButton(
							onPressed: _handleLog,
					color: Colors.blue,
					child: new Text( (_log == true) ? "se Connecter" : "S'incrire",
						style:  new TextStyle(color: Colors.white, fontSize: 20.0),) ,
					),

				],
			),
		)
		);
}

_handleLog() {
if(_mail != null){
	if(_password != null){
		if(_log == true){
			// se connecter
			FirebaseHelper().handleSignIn(_mail, _password).then((FirebaseUser user) {
			print("Nous avons un user !");
			}).catchError((error){
				alerte(error.toString());
			}
			);
		} else {
			if(_prenom != null){
				if(_nom != null){
					// créer un compte
					FirebaseHelper().handleCreate(_mail, _password, _prenom, _nom).then((FirebaseUser user) {
						print("Nous avons pu créer un utilisateur");
					}).catchError((error){
						alerte(error.toString());
					});
				}else{
					//alerte nom
					alerte("Veuillez entrer votre nom");
				}
			} else {
				// alerte prenom
				alerte("Veuillez entrer un prénom pour continuer");
			}
		}
	}else{
		// alert password
		alerte("Le mot de passe est vide");
	}
}else{
	//alert mail
	alerte("L'adresse mail est vide");
}
}

Future<void> alerte(String error) async {
		Text titre = new Text("Nous avons une erreur");
		Text sousTitre = new Text(error);

		return showDialog(
				context: context,
		barrierDismissible: false,
		builder: (BuildContext buildContext){
			return (Theme.of(context).platform == TargetPlatform.iOS) ? new CupertinoAlertDialog(
				title: titre,
				content: sousTitre,
				actions: <Widget>[
					okButton(buildContext)
				],
			) : new AlertDialog(
				title: titre,
				content: sousTitre,
				actions: <Widget>[
					okButton(buildContext),
				],
			);
		}
		);
}

FlatButton okButton(BuildContext context){
		return new FlatButton(
				onPressed: () => Navigator.of(context).pop(),
				child: new Text("OK"));
}

List<Widget> cardElements(){
		List<Widget> widgets = [];
		widgets.add(
			new TextField(
				decoration: new InputDecoration(
					hintText: "Entrez votre adresse mail"
				),
				onChanged: (String str){
					setState(() {
					  _mail = str;
					});
				},
			)
		);

		widgets.add(
				new TextField(
					obscureText: true,
					decoration: new InputDecoration(
							hintText: "Entrez votre mot de passe",
					),

					onChanged: (String str){
						setState(() {
							_password = str;
						});
					},
				)
		);

		if(_log == false) {
			widgets.add(
					new TextField(
						decoration: new InputDecoration(
								hintText: "Entrez votre prénom"
						),
						onChanged: (String str){
							setState(() {
								_prenom = str;
							});
						},
					)
			);

			widgets.add(
					new TextField(
						decoration: new InputDecoration(
								hintText: "Entrez votre nom"
						),
						onChanged: (String str){
							setState(() {
								_nom = str;
							});
						},
					)
			);
		}
	widgets.add(
		new FlatButton(
				onPressed: (){
					setState(() {
					  _log = !_log;
					});
				},
				child: new Text(
						(_log == true) ? "Pour créer un compte, appuyer ici" : "Vous avez déjà un compte? appuyer ici"
				))
	);
		return widgets;
	}


}