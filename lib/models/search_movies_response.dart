import 'dart:convert';
import 'package:peliculas_flutter/models/models.dart';

class SearchResponse {
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  SearchResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SearchResponse.fromJson(String str) =>
      SearchResponse.fromMap(json.decode(str));

  factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) =>Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
