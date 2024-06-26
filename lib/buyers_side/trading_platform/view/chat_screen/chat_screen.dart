import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/buyers_side/services/firestore_services.dart';
import 'package:farm2fabric/buyers_side/trading_platform/view/chat_screen/%20components/sender_bubble.dart';
import 'package:farm2fabric/buyers_side/trading_platform/view/chat_screen/controller/chats_controller.dart';
import 'package:farm2fabric/buyers_side/widgets_common/loading_indicator.dart';

class ChatScreen extends StatelessWidget {
  final ChatsController controller = Get.put(ChatsController(
    friendName: Get.arguments?[0],
    friendId: Get.arguments?[1],
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text("${controller.friendName ?? 'Chat'}")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('chats').doc(controller.chatDocId).collection('messages').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("Send a message..."));
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot data = snapshot.data!.docs[index];
                        return Align(
                          alignment: data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                          child: senderBubble(data),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.messageController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: textfieldGrey)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: textfieldGrey)),
                      hintText: "Type a message",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.sendMsg(controller.messageController.text);
                    controller.messageController.clear();
                  },
                  icon: Icon(Icons.send, color: redColor),
                ),
              ],
            ).paddingOnly(left: 16, right: 16, bottom: 8),
          ],
        ),
      ),
    );
  }
}


// class ChatScreen extends StatelessWidget {
//   const ChatScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(ChatsController());

//     return Scaffold(
//         backgroundColor: whiteColor,
//         appBar: AppBar(
//           title: "${controller.friendName}"
//               .text
//               .fontFamily(semibold)
//               .color(darkFontGrey)
//               .make(),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Obx(() => controller.isLoading.value
//                   ? Center(
//                       child: loadingIndicator(),
//                     )
//                   : Expanded(
//                       child: StreamBuilder(
//                         stream: FirestoreServices.getChatMessages(
//                             controller.chatDocId.toString()),
//                         builder: ((BuildContext context,
//                             AsyncSnapshot<QuerySnapshot> snapshot) {
//                           if (!snapshot.hasData) {
//                             return Center(
//                               child: loadingIndicator(),
//                             );
//                           } else if (snapshot.data!.docs.isEmpty) {
//                             return Center(
//                               child: "Send a message..."
//                                   .text
//                                   .color(darkFontGrey)
//                                   .make(),
//                             );
//                           } else {
//                             return ListView(
//                               children: snapshot.data!.docs
//                                   .mapIndexed((currentValue, index) {
//                                 var data = snapshot.data!.docs[index];
//                                 return Align(
//                                     alignment: data['uid'] == currentUser!.uid
//                                         ? Alignment.centerRight
//                                         : Alignment.centerLeft,
//                                     child: senderBubble(data));
//                               }).toList(),
//                             );
//                           }
//                         }),
//                       ),
//                     )),
//               20.heightBox,
//               Row(
//                 children: [
//                   Expanded(
//                       child: TextFormField(
//                     controller: controller.messageController,
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(
//                         borderSide: BorderSide(color: textfieldGrey),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: textfieldGrey)),
//                       hintText: "Type a message",
//                     ),
//                   )),
//                   IconButton(
//                       onPressed: () {
//                         controller.sendMsg(controller.messageController.text);
//                         controller.messageController.clear();
//                       },
//                       icon: const Icon(
//                         Icons.send,
//                         color: redColor,
//                       ))
//                 ],
//               )
//                   .box
//                   .height(80)
//                   .padding(const EdgeInsets.symmetric(horizontal: 16))
//                   .margin(const EdgeInsets.only(bottom: 08))
//                   .make()
//             ],
//           ),
//         ));
//   }
// }
