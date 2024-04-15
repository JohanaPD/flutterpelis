import 'dart:convert';

import 'package:peliculas_flutter/models/models.dart';

class TvPopularSeries {
  int page;
  List<TVSerie> results;
  int totalPages;
  int totalResults;

  TvPopularSeries({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TvPopularSeries.fromJson(String str) =>
      TvPopularSeries.fromMap(json.decode(str));
  factory TvPopularSeries.fromMap(Map<String, dynamic> json) => TvPopularSeries(
        page: json["page"] ?? 0,
        results:
            List<TVSerie>.from(json["results"].map((x) => TVSerie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
