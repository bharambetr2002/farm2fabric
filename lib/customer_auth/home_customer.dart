import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/education_page/blog.dart';
import 'package:farm2fabric/market_information/view/news_main.dart';
import 'package:farm2fabric/trading_platform/view/home_screen/trading_home.dart';

class Home_Customer extends StatelessWidget {
  const Home_Customer({Key? key}) : super(key: key);

  void onCardTap(String title, BuildContext context) {
    switch (title) {
      case 'Market Information':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewsScreen()));
        break;
      case 'Learn':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BlogPage()));
        break;
      case 'Warehouse':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewsScreen()));
        break;
      case 'Trade':
        Get.to(() => const TradingHome());
        break;
      case 'Market':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewsScreen()));
        break;
      case 'Service':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NewsScreen()));
        break;
      default:
        print('Unknown screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Farm2Fabric"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        toolbarHeight: 56,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text(
              "Hey User",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),

            10.heightBox,
            Image.asset(
              'assets/images/logo.png',
              height: 110,
              alignment: Alignment.center,
            ),

            10.heightBox,
            const Text(
              "Welcome, back to",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            10.heightBox,
            const Text(
              "Farm2Fabric",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            // Adding the 2x2 grid view with equal spacing
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing:
                      10.0, // Adjust this value for desired vertical spacing
                  crossAxisSpacing:
                      10.0, // Adjust this value for desired horizontal spacing
                ),
                itemBuilder: (BuildContext context, int index) {
                  final title = [
                    'Market Information',
                    'Learn',
                    'Warehouse',
                    'Trade',
                    'Market',
                    'Service'
                  ][index];
                  return GestureDetector(
                    onTap: () => onCardTap(title, context),
                    child: GridItem(title: title),
                  );
                },
                itemCount: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String title;

  const GridItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
