import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data) {
  var t = data['created_on'] == null ? DateTime.now() : (data['created_on'] as Timestamp).toDate();
  var time = intl.DateFormat('h:mma').format(t);
  return Directionality(
    textDirection: data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data['msg'], style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 10),
          Text(time, style: TextStyle(color: whiteColor.withOpacity(0.5), fontSize: 12)),
        ],
      ),
    ),
  );
}

// Widget senderBubble(DocumentSnapshot data) {
//   var t =
//       data['created_on'] == null ? DateTime.now : data['created_on'].toDate();
//   var time = intl.DateFormat('h:mma').format(t);
//   return Directionality(
//       textDirection: data['uid'] == currentUser!.uid
//           ? TextDirection.rtl
//           : TextDirection.ltr,
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 08),
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//               bottomLeft: Radius.circular(20)),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             "${data['msg']}".text.white.size(16).make(),
//             .10.heightBox,
//             time.text.color(whiteColor.withOpacity(0.5)).size(12).make()
//           ],
//         ),
//       ));
// }
