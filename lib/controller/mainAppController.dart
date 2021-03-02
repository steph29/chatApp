import 'package:chatapp/models/firebaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/controller/contactController.dart';
import 'package:chatapp/controller/profilController.dart';
import 'package:chatapp/controller/messagesController.dart';
import 'package:flutter/cupertino.dart';

class MainAppcontroller extends StatefulWidget {
MainAppState createState() => new MainAppState();

}

class MainAppState extends State<MainAppcontroller>{
	
	String id;

	@override
	void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseHelper().myId().then((uid) {
    	setState(() {
    		id = uid;
    	});
    });
  }
	
	@override
	Widget build(BuildContext context) {
		Text title = new Text("ChatApp");
		return new FutureBuilder(
			future: FirebaseHelper().auth.currentUser(),
				builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
				if(snapshot.connectionState == ConnectionState.done){
					if(Theme.of(context).platform == TargetPlatform.iOS){
						return new CupertinoTabScaffold(
								tabBar: new CupertinoTabBar(
									backgroundColor: Colors.blue,
										activeColor: Colors.white,
										inactiveColor: Colors.blue[800],
										items: [
											new BottomNavigationBarItem(icon: new Icon(Icons.message),),
											new BottomNavigationBarItem(icon: new Icon(Icons.supervisor_account),),
											new BottomNavigationBarItem(icon: new Icon(Icons.account_circle),),
										]),
								tabBuilder: (BuildContext context, int index){
									Widget controllerSelected = controllers()[index];
									return new Scaffold(
										appBar: new AppBar(
											title: title,
										),
										body: controllerSelected,
									);
								});
					}else{
						return new DefaultTabController(length: 3, child: new Scaffold(
							appBar: new AppBar(
								title: title,
								bottom: new TabBar(tabs: [
									new Tab(icon: new Icon(Icons.message),),
									new Tab(icon: new Icon(Icons.supervisor_account),),
									new Tab(icon: new Icon(Icons.account_circle),),
								]),
							),
							body: new TabBarView(
									children: controllers(),),
						)
						);
					}
				}else{
					// retourne Widget chargement
					return new Scaffold(
						appBar: new AppBar(
							title: title,
						),
						body: new Center(
							child: new Text("Chargement .. ", style: new TextStyle( fontSize: 25.0, fontStyle: FontStyle.italic, color: Colors.blue),),
						) ,
					);
				}
				},
		);
  }

  List<Widget> controllers (){
		return [
			new MessagesController(id),
			new ContactController(id),
			new ProfilController(id),
		];
}
}