import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';

Future<FirebaseUser> signInWithTwitter(consumerKey , consumerSecret) async {
  // Create a TwitterLogin instance
  final TwitterLogin twitterLogin = new TwitterLogin(
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
  );

  // Trigger the sign-in flow
  final TwitterLoginResult loginResult = await twitterLogin.authorize();

  // Get the Logged In session
  final TwitterSession twitterSession = loginResult.session;

  // Create a credential from the access token
  final twitterAuthCredential = TwitterAuthProvider.getCredential(authToken:twitterSession.token, authTokenSecret:twitterSession.secret);

  // Once signed in, return the UserCredential
  FirebaseUser currentUser = (await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential)).user;
  //print(currentUser.displayName);
  return currentUser;

}