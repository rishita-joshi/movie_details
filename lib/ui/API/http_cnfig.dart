import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:task_movie/model/movie_details_reponse.dart';

import '../../model/movie_response.dart';

class HttPConfig {
  static const String API_BASE = "https://api.themoviedb.org/3/movie/";

  static const String API_Key = "35eba6de1b3da6f029605f11595f9374";

  // static const String API_BASE_URL =
  //     "https://api.themoviedb.org/3/movie/550?api_key=35eba6de1b3da6f029605f11595f9374";
  // static const String token =
  //     "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzNWViYTZkZTFiM2RhNmYwMjk2MDVmMTE1OTVmOTM3NCIsInN1YiI6IjY0NDIwMTI4YmYzMWYyMDUyN2E4ZmI2MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.T3RwNigXmJ8uYpBD7slhwo9uSCH8xQsTV48BxOPe4yo";

  static Future<MovieResponse> getUserDetails(String categoryName) async {
    print(categoryName);
    final response = await http.get(
      //       Uri.parse(
      //       "$API_BASE+$categoryName?api_key=35eba6de1b3da6f029605f11595f9374&language=en-US&page=1"),
      //  );
      Uri.parse(
          "$API_BASE$categoryName?api_key=35eba6de1b3da6f029605f11595f9374&language=en-US&page=1%0A"),
    );
    print(response);
    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);
      print(response.body);
      MovieResponse list = MovieResponse.fromJson(parsed);
      return list;
    } else {
      throw Exception('Failed to load Data');
    }
  }

  static Future<MovieDetailsResponse> getMovieDetails(int movieId) async {
    print("-->${movieId}");
    final response = await http.get(Uri.parse(
            "https://api.themoviedb.org/3/movie/$movieId?api_key=35eba6de1b3da6f029605f11595f9374&language=en-US")

        //$API_BASE$movieId?api_key=$API_Key&language=en-US"),
        );
    print(response);
    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);
      print(response.body);
      MovieDetailsResponse list = MovieDetailsResponse.fromJson(parsed);
      return list;
    } else {
      throw Exception('Failed to load Data');
    }
  }
}
