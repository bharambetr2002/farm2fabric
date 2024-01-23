import 'package:farm2fabric/market_information/view/news_main.dart';
import 'package:flutter/material.dart';

class Home_Guest extends StatelessWidget{
  const Home_Guest({Key? key}) : super(key: key);

  void onCardTap(String title, BuildContext context) {
    switch (title) {
      case 'Market Information':
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsScreen()));
        break;
      case 'Learn':
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsScreen()));
        break;
      case 'Warehouse':
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsScreen()));
        break;
      case 'Trade':
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewsScreen()));
        break;
      default:
        print('Unknown screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Farm2Fabric"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        toolbarHeight: 56,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 10),
        child: Column(
          children: [
            const Text(
              "Hey User",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 15),

            Image.asset(
              'assets/images/logo.png',
              height: 110,
              alignment: Alignment.center,
            ),

            const SizedBox(height: 15),

            const Text(
              "Welcome, back to",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 15),

            const Text(
              "Farm2Fabric",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            // Adding the 2x2 grid view with equal spacing
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0, // Adjust this value for desired vertical spacing
                  crossAxisSpacing: 10.0, // Adjust this value for desired horizontal spacing
                ),
                itemBuilder: (BuildContext context, int index) {
                  final title = ['Market Information', 'Learn', 'Warehouse', 'Trade'][index];
                  return GestureDetector(
                    onTap: () => onCardTap(title, context),
                    child: GridItem(title: title),
                  );
                },
                itemCount: 4,
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