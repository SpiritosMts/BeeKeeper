import 'dart:async';

import 'package:beekeeper/_auth/login_screen.dart';
import 'package:beekeeper/main.dart';
import 'package:beekeeper/models/bkUserModel.dart';
import 'package:beekeeper/myPacks/firebase/fireBase.dart';
import 'package:beekeeper/myPacks/myConstants.dart';
import 'package:beekeeper/myPacks/myVoids.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  late Rx<GoogleSignInAccount?> googleSignInAccount;

  BkUser cUser = BkUser();
  late  Worker worker;
  late  Worker workerGgl;

  int myCoins = 0;
  StreamSubscription? userStream;

  @override
  void onInit() {
    print('## onInit AuthController');


  }

  @override
  void onClose() {
    super.onClose();
    print('## close AuthController');
    userStream!.cancel();
  }


  deleteUserFromAuth(email,pwd) async {
    //auth user to delete
  await auth.signInWithEmailAndPassword(
    email: email,
    password: pwd,
  ).then((value) async {
    print('## account: <${authCurrUser!.email}> deleted');
    //delete user
    authCurrUser!.delete();
    //signIn with admin
    await auth.signInWithEmailAndPassword(
      email: cUser.email!,
      password: cUser.pwd!,
    );
    print('## admin: <${authCurrUser!.email}> reSigned in');

  });




}

  void fetchUser() {
    print('## AuthController fetchUser ...');

    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

    // this detect google and not-google users
    firebaseUser.bindStream(auth.userChanges());
    worker = ever(firebaseUser, _setInitialScreen);

  }

  // need this once, that's why i dispose it at entrance
  _setInitialScreen(User? user) async {
    print('# _setInitialScreen');
    worker.dispose();

    if (user == null) {//no user found
      //print('## no user Found');
      print('## user == null');
      Get.offAll(() => LoginScreen());

    } else {//user who can be signed in found found
      print('## user != null');
      //print('## User stayed signed in >> ${user.email!}');
      await getUserInfoVoid(user.email).then((value) {
        checkUserVerif();
      });

    }
  }

  checkUserVerif() {
    print('## checking account verification...');

    if (cUser.verified) {
      print('## <account> verified');
      goToHomePage();
    }
    else {
      print('## <account> NOT verified');
      MyVoids().showShouldVerify();

    }
  }
  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) async {
    print('# _setInitialScreenGoogle');
    workerGgl.dispose();


    if (googleSignInAccount == null) {
      print('## google-user == null');
      Get.offAll(() => LoginScreen());

    } else {
      //print('## google-User stayed signed in >> ${googleSignInAccount.email}');
      print('## google-user != null');

      await getUserInfoVoid(googleSignInAccount.email).then((value) {
        checkUserVerif();
      });
    }

  }

  void signInWithGoogle() async {
    try {
      print('## try to googleSignIn');

      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) { // is a true ggl account

        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth.signInWithCredential(credential).then((value) {}).catchError((onErr) => print(onErr));


        // try signIn or signUp with google
        await usersColl.where('email', isEqualTo: googleSignInAccount.email).get().then((event) async {
          var userDocsLength = event.docs.length; // check if there is an account resistred in db with that email
          if(userDocsLength == 0){// no account
            print('## should create new google account');
            addDocument(
                fieldsMap: {
                  'name': googleSignInAccount.displayName,
                  'email': googleSignInAccount.email,
                  'pwd': 'this-is-google-user-pwd',
                  'joinDate': todayToString(),
                  'isAdmin': false,
                  'verified':true,
                  'coins': '0',
                },
                collName: usersCollName

            ).then((value) async {
              await getUserInfoVoid(googleSignInAccount.email).then((value) {
                checkUserVerif();
              });
            });
          }else{
            print('## google account already registred');
            await getUserInfoVoid(googleSignInAccount.email).then((value) {
              checkUserVerif();
            });
          }


        });
      }
    } catch (e) {


      MyVoids().showTos("connection error".tr);
      print('## error while trying to sign in with ggl: $e');
    }
  }

  void signIn(String _email, String _password,  {Function()? onSignIn}) async {
    try {
      print('## try to signIn');

      //try signIn
      await auth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      )
          .then((value) async {
        //account found
        await authCtr.getUserInfoVoid(_email).then((value) {
          authCtr.checkUserVerif();
        });
      });

      // signIn error
    } on FirebaseAuthException catch (e) {
      print('## error signIn => ${e.message}');
      if (e.code == 'user-not-found') {
        MyVoids().showTos('User not found'.tr);
        print('## user not found');
      } else if (e.code == 'wrong-password') {
        MyVoids().showTos('Wrong password'.tr);
        print('## wrong password');
      }
    } catch (e) {
      print('## catch err in signIn user_auth: $e');
    }
  }

  void signUp(String _email, String _password, {Function()? onSignUp}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      )
          .then((value) {
        onSignUp!();
      });
    } on FirebaseAuthException catch (e) {
      print('## error signUp => ${e.message}');

      if (e.code == 'weak-password') {
        MyVoids().showTos('Weak password'.tr);
        print('## weak password.');
      } else if (e.code == 'email-already-in-use') {
        MyVoids().showTos('Email already in use'.tr);
        print('## email already in use');
      }
    } catch (e) {
      print('## catch err in signUp user_auth: $e');
    }
  }












  void ResetPss(String email, ctx) async {
    try {
      await auth.sendPasswordResetEmail(email: email).then((uid) {
        MyVoids().showTos('password reset has been sent to your mailbox'.tr);
        Get.back();
      }).catchError((e) {
        print('## catchError while ResetPss => $e');
        MyVoids().showTos('Enter a valid email'.tr);

      });
    } on FirebaseAuthException catch (e) {
      MyVoids().showTos('connection error'.tr);
      print('## Error sending reset pass' + e.message.toString());
    }
  }


  void signOut() async {
    await auth.signOut();
    await googleSign.signOut();
    cUser = BkUser();
    sharedPrefs!.setBool('isGuest', false);
    //Get.delete<AuthController>();
    //fetchUser();
    print('## user signed out');
  }

  // send verif code screen
  Future<void> verifyUserEmail(timer) async {
    //user = authCurrUser!;
    await authCurrUser!.reload();
    if (authCurrUser!.emailVerified) {

      await usersColl.where('email', isEqualTo: authCurrUser!.email).get().then((event) {
        var userDoc = event.docs.single;
        String userID = userDoc.get('id');
        usersColl.doc(userID).update({
          'verified':true
        });


      });
      print('### account verified');
      timer.cancel();
      MyVoids().showTos('your account has been verified\nplease reconnect'.tr);
      Get.offAll(()=>LoginScreen());
    }
  }

  refreshCuser() async {
    getUserInfoVoid(authCtr.cUser.email);
  }

  saveEnteredEmail(String newEnteredEmail){
    RegExp regex = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");
    List<String>? savedEmails = sharedPrefs!.getStringList('savedEmails') ?? [];

    if(newEnteredEmail.isNotEmpty && regex.hasMatch(newEnteredEmail) && !savedEmails.contains(newEnteredEmail)){
      savedEmails.add(newEnteredEmail);
      sharedPrefs!.setStringList('savedEmails', savedEmails);
      print('## +saved entered Emails: $savedEmails');
    }
  }

  Future<void> getUserInfoVoid(userEmail) async {
    await usersColl.where('email', isEqualTo: userEmail).get().then((event) {
      var userDoc = event.docs.single;
      cUser = BkUserFromMap(userDoc);
      printUser(cUser);

    }).catchError((e) => print("## cant find user in db: $e"));


  }
}
