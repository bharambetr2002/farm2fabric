import 'package:farm2fabric/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReadBlogPage extends StatelessWidget {
  final String blogId;

  const ReadBlogPage({Key? key, required this.blogId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text("Blog Details"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('blogs')
            .doc(blogId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var blogData = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blogData['title'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Author: ${blogData['authorName']}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  blogData['desc'],
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Image.network(
                  blogData['imgUrl'],
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
