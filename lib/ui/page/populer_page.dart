import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_movie/model/movie_response.dart';
import 'package:task_movie/provider/list_provider.dart';
import 'package:task_movie/ui/API/http_cnfig.dart';
import 'package:task_movie/ui/page/movie_details.dart';
import 'package:provider/provider.dart';

class PopulerWidget extends StatefulWidget {
  const PopulerWidget({super.key});

  @override
  State<PopulerWidget> createState() => _PopulerWidgetState();
}

class _PopulerWidgetState extends State<PopulerWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ListProvider>(builder: (context, providerObj, child) {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<MovieResponse>(
                  future: HttPConfig.getUserDetails("popular"),
                  builder: (context, snapshot) {
                    print(snapshot);
                    if (snapshot.hasData) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: SizedBox(
                                height: 40,
                                width: 40,
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
                            return Center(
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: ListTile(
                                  //         // trailing: Image.network(
                                  //         //     "https://api.themoviedb.org/3/movie${movieResponse?.results[index].posterPath}"),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MovieDetails(
                                              movieId: movieResponse
                                                  .results[index].id)),
                                    );
                                  },
                                  title:
                                      Text(movieResponse.results[index].title),
                                ),
                              ),
                            );
                          }),
                        );

                        //  ListView.builder(
                        //   shrinkWrap: true,
                        //   itemCount: movieResponse?.results.length,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return SizedBox(
                        //       height: 40,
                        //       child: ListTile(
                        //         // trailing: Image.network(
                        //         //     "https://api.themoviedb.org/3/movie${movieResponse?.results[index].posterPath}"),
                        //         onTap: () {
                        //           Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => MovieDetails(
                        //                       movieId: movieResponse
                        //                           .results[index].id

                        //                     )),
                        //           );
                        //         },
                        //         title:
                        //             Text(movieResponse!.results[index].title),
                        //       ),
                        //     );
                        //   },
                        // );
                      } else {
                        return Text(snapshot.error.toString());
                      }
                    }
                    return Center(
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator()));
                  }),
            )
            //: Text("hee")
          ],
        ),
      );
    });
  }
}
