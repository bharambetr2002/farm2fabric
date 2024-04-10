import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2fabric/buyers_side/consts/consts.dart';
import 'package:farm2fabric/buyers_side/trading_platform/controller/home_controller.dart';

class ChatsController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String? friendName;
  final String? friendId;
  final String? currentId = currentUser?.uid;
  final TextEditingController messageController = TextEditingController();
  bool isLoading = false;
  String? chatDocId;

  ChatsController({this.friendName, this.friendId});

  @override
  void onInit() {
    super.onInit();
    getChatId();
  }

  void getChatId() async {
    try {
      isLoading = true;
      update();
      
      final QuerySnapshot querySnapshot = await firestore
          .collection(chatsCollection)
          .where('users', isEqualTo: {friendId: null, currentId: null})
          .limit(1)
          .get();
      
      if (querySnapshot.docs.isNotEmpty) {
        chatDocId = querySnapshot.docs[0].id;
      } else {
        final DocumentReference docRef = await firestore.collection(chatsCollection).add({
          'created_on': null,
          'last_msg': '',
          'users': {friendId: null, currentId: null},
          'toId': '',
          'fromId': '',
          'friend_Name': friendName,
          'sender_Name': Get.find<HomeController>().username,
        });
        chatDocId = docRef.id;
      }
    } catch (error) {
      print("Error fetching chat ID: $error");
    } finally {
      isLoading = false;
      update();
    }
  }

  void sendMsg(String msg) async {
    try {
      if (msg.trim().isNotEmpty && chatDocId != null) {
        await firestore.collection(chatsCollection).doc(chatDocId).update({
          'created_on': FieldValue.serverTimestamp(),
          'last_msg': msg,
          'toId': friendId,
          'fromId': currentId,
        });

        await firestore.collection(chatsCollection).doc(chatDocId).collection(messagesCollection).add({
          'created_on': FieldValue.serverTimestamp(),
          'msg': msg,
          'uid': currentId,
        });
      }
    } catch (error) {
      print("Error sending message: $error");
    }
  }
}

// class ChatsController extends GetxController {
//   @override
//   void onInit() {
//     getChatId();
//     super.onInit();
//   }

//   var chats = firestore.collection(chatsCollection);
//   var friendName = Get.arguments[0];
//   var friendId = Get.arguments[1];

//   var senderName = Get.find<HomeController>().username;
//   var currentId = currentUser!.uid;

//   var messageController = TextEditingController();

//   dynamic chatDocId;

//   var isLoading = false.obs;

//   getChatId() async {
//     isLoading(true);

//     await chats
//         .where('users', isEqualTo: {friendId: null, currentId: null})
//         .limit(1)
//         .get()
//         .then((QuerySnapshot snapshot) {
//           if (snapshot.docs.isNotEmpty) {
//             chatDocId = snapshot.docs[0].id;
//           } else {
//             chats.add({
//               'created_on': null,
//               'last_msg': '',
//               'users': {friendId: null, currentId: null},
//               'toId': '',
//               'fromId': '',
//               'friend_Name': friendName,
//               'sender_Name': senderName
//             }).then((value) {
//               chatDocId = value.id;
//             });
//           }
//         });

//     isLoading(false);
//   }

//   sendMsg(String msg) async {
//     if (msg.trim().isNotEmpty) {
//       chats.doc(chatDocId).update({
//         'created_on': FieldValue.serverTimestamp(),
//         'last_msg': msg,
//         'toId': friendId,
//         'fromId': currentId,
//       });

//       chats.doc(chatDocId).collection(messagesCollection).doc().set({
//         'created_on': FieldValue.serverTimestamp(),
//         'msg': msg,
//         'uid': currentId,
//       });
//     }
//   }
// }
