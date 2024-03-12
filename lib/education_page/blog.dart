import 'package:farm2fabric/education_page/readblog_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/education_page/create_blog.dart';
import 'package:farm2fabric/education_page/crud.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  CrudMethods crudMethods = CrudMethods();

  late Stream<QuerySnapshot> blogsStream;

  Widget blogsList() {
    ScrollController _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getMoreBlogs();
      }
    });

    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: blogsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('Something went wrong.'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No blogs available.'));
          }

          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var blogData =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
              if (blogData == null) {
                return SizedBox
                    .shrink(); // If blogData is null, return an empty SizedBox
              }
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReadBlogPage(
                        blogId: snapshot.data!.docs[index].id,
                      ),
                    ),
                  );
                },
                child: BlogsTile(
                  title: blogData['title'] ??
                      '', // Provide a default value for title if it's null
                  authorName: blogData['authorName'] ?? '',
                  // Provide a default value for authorName if it's null
                  imgUrl: blogData['imgUrl'] ?? '',
                  // Provide a default value for imgUrl if it's null
                ),
              );
            },
          );
        },
      ),
    );
  }

  void getMoreBlogs() {
    // Fetch more blogs here
  }

  @override
  void initState() {
    super.initState();
    blogsStream = crudMethods.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Flutter",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "Blog",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: blogsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateBlog()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class BlogsTile extends StatelessWidget {
  final String imgUrl, title, authorName;
  const BlogsTile({
    required this.imgUrl,
    required this.title,
    required this.authorName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (imgUrl.isNotEmpty)
            AspectRatio(
              aspectRatio: 16 / 9, // Specify the aspect ratio here
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Author: $authorName',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Divider(height: 20, color: Colors.grey[300]),
        ],
      ),
    );
  }
}
