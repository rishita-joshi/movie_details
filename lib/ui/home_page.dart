import 'package:flutter/material.dart';
import 'package:task_movie/provider/list_provider.dart';
import 'package:task_movie/ui/page/populer_page.dart';
import 'package:task_movie/ui/page/top_rated_page.dart';
import 'package:task_movie/ui/page/upcomming_page.dart';
import 'package:provider/provider.dart';

class TabBarDemo extends StatefulWidget {
  TabBarDemo({Key? key}) : super(key: key);

  @override
  State<TabBarDemo> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  int _crossAxisCount = 2;

  double _aspectRatio = 1.5;

  ViewType _viewType = ViewType.grid;

// build the app
  @override
  Widget build(BuildContext context) {
    return Consumer<ListProvider>(builder: (context, providerObj, child) {
      return MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: Icon(_viewType == ViewType.list
                      ? Icons.grid_on
                      : Icons.view_list),
                  onPressed: () {
                    providerObj.changeViewType();
                  },
                )
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(text: "Popular", icon: Icon(Icons.music_note)),
                  Tab(text: " Top Rated", icon: Icon(Icons.music_video)),
                  Tab(text: "Upcoming", icon: Icon(Icons.camera_alt)),
                ],
              ), // TabBar
              title: Text('Movie_details'),
            ), // AppBar
            body: TabBarView(
              children: [
                PopulerWidget(),
                TopRatedPage(),
                UpcommingPage(),
              ],
            ), // TabBarView
          ),
        ),
      );
    });
  }

  //       }), // Scaffold
  //     ), // DefaultTabController
  //   ); // MaterialApp
}
