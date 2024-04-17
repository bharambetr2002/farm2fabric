import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  var isloading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController emailController =
      TextEditingController(text: 'admin@ges.com');
  final TextEditingController passwordController =
      TextEditingController(text: '1234567');

  Future<UserCredential?> login({required BuildContext context}) async {
    try {
      isloading(true);
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      return userCredential;
    } catch (e) {
      VxToast.show(context, msg: e.toString());
      return null;
    } finally {
      isloading(false);
    }
  }

  Future<UserCredential?> signup(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      isloading(true);
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } catch (e) {
      VxToast.show(context, msg: e.toString());
      return null;
    } finally {
      isloading(false);
    }
  }

  Future<void> storeUserData(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        final store =
            _firestore.collection(usersCollection).doc(currentUser.uid);
        await store.set({
          'name': name,
          'email': email,
          'password': password,
          'imgUrl': '',
          'id': currentUser.uid,
          'cart_count': "0",
          'wishlist_count': "0",
          'order_count': "0",
        });
      }
    } catch (e) {
      print('Error storing user data: $e');
    }
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // Handle error
      print('Error signing out: $e');
    }
  }
}
