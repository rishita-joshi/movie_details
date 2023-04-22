import 'package:flutter/material.dart';
import 'package:task_movie/model/movie_response.dart';
import 'package:task_movie/ui/API/http_cnfig.dart';
import 'package:task_movie/ui/page/movie_details.dart';
import 'package:provider/provider.dart';

import '../../provider/list_provider.dart';

class TopRatedPage extends StatefulWidget {
  const TopRatedPage({super.key});

  @override
  State<TopRatedPage> createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
  @override
  void initState() {
    // HttPConfig.getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ListProvider>(builder: (context, providerObj, child) {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<MovieResponse>(
                  future: HttPConfig.getUserDetails("top_rated"),
                  builder: (context, snapshot) {
                    print(snapshot);
                    if (snapshot.hasData) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator()));
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        MovieResponse? movieResponse = snapshot.data;
                        print(movieResponse);
                        return GridView.count(
                          crossAxisCount: providerObj.crossAxisCount,
                          childAspectRatio: providerObj.aspectRatio,
                          children: List.generate(movieResponse!.results.length,
                              (index) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MovieDetails(
                                                movieId: movieResponse
                                                    .results[index].id)),
                                      );
                                    },
                                    title: Text(
                                        movieResponse.results[index].title),
                                  ),
                                ]);
                          }),
                        );
                      } else {
                        return Text(snapshot.error.toString());
                      }
                    }
                    return SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator());
                  }),
            ),
          ],
        ),
      );
    });
  }
}
