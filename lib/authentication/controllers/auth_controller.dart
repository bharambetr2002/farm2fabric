import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  //textcontroller

  var emailController = TextEditingController(text: 'admin@ges.com');
  var passwordController = TextEditingController(text: '123456');

  //login method

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {

      VxToast.show(context, msg: e.toString());

    }
    return userCredential;
  }


  //signup method

  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());

    }
    return userCredential;
  }


  //storing user data

  storeUserData({name, password, email}) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'email': email,
      'password': password,
      'imgUrl': '',

      'id': currentUser!.uid,
    });
  }


//signout method

  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {

      VxToast.show(context, msg: e.toString());

    }
  }
}
