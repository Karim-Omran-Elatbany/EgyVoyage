import 'package:flutter/material.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/mostrecentlistviewbuilder.dart';
import '../widgets/placeslistviewbuilder.dart';
import '../widgets/sideBar.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: HomeAppBar(),
      ),
      drawer: const SideBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Most Recent',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                Row(
                  children: [
                    Expanded(
                        child: Container(
                            height: 200, child: MostRecentListViewbulider())),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Most Trending',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                placeslistviewbuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
