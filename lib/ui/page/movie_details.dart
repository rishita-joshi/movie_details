import 'package:flutter/material.dart';
import 'package:task_movie/model/movie_details_reponse.dart';
import 'package:task_movie/ui/API/http_cnfig.dart';

import '../../model/movie_response.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key, required this.movieId});
  final int movieId;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Details"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<MovieDetailsResponse>(
                future: HttPConfig.getMovieDetails(widget.movieId),
                builder: (context, snapshot) {
                  print(snapshot);
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(child: CircularProgressIndicator()));
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      MovieDetailsResponse? movieResponse = snapshot.data;
                      print(movieResponse);

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 100,
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(movieResponse!.originalTitle
                                          .toString()
                                    ),
                                  Text(movieResponse.popularity.toString()),
                                  Text(movieResponse.adult.toString()),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Text(snapshot.error.toString());
                    }
                  }
                  return SizedBox(
                      width: 50,
                      height: 50,
                      child: Center(child: CircularProgressIndicator()));
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
