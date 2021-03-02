import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMessaging  {
	final FirebaseMessaging _fcm = FirebaseMessaging();

	Future initialise() async {
		if(Platform.isIOS){
			// request permission if we're on iOS
			_fcm.requestNotificationPermissions(IosNotificationSettings());
		}

		_fcm.configure(
			// Called when the app is in the foreground and receive a push notification
			onMessage: (Map <String, dynamic> message) async {
				print("onMessage : $message");
			},
			// Called when the app is in the background and it's opened  from the push notification
			onResume: (Map <String, dynamic> message) async {
				print("onResume : $message");
			},
			// Called when the app has been closed completely and it's opened from the push notification
			onLaunch: (Map <String, dynamic> message) async {
				print("onLaunch : $message");
			},
		);
	}

}

