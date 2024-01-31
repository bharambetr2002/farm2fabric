import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  // text controllers

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // login method

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString(), bgColor: Vx.blue100);
    }
    return userCredential;
  }

  // signup method

  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString());
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString(), bgColor: Vx.green400);
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
      'id': currentUser!.uid,
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
