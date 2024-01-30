import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthControleer extends GetxController {
  var isloading = false.obs;

  // text controllers

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // login method

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString());
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // signup method

  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      await auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString());
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString(), bgColor: Vx.red500);
    }
    return userCredential;
  }

  //  storing data method

  storeUserData({name, password, email}) async {
    DocumentReference store =
        await firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      //'id': currentUser!.uid,
    });
  }

  // signout method
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString(), bgColor: Vx.red500);
    }
  }
}
