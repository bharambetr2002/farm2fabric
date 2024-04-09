import 'package:farm2fabric/buyers_side/consts/consts.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0.obs;

  var username = ''.obs;

Future<void> getUsername() async {
  var n = await firestore
      .collection(usersCollection)
      .doc(currentUser!.uid) // Use doc() instead of where() to directly fetch the document by ID
      .get()
      .then((value) {
    if (value.exists) {
      return value.data()!['name']; // Use data() to get the document data
    }
  });
  username.value = n ?? 'Unknown'; // Update username with value from Firestore or default to 'Unknown'
  print(username.value);
}
}
