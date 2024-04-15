// ignore_for_file: unused_field, unnecessary_new, unnecessary_this

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_flutter/helpers/Debouncer.dart';
import 'package:peliculas_flutter/models/models.dart';

class SeriesProvider extends ChangeNotifier {
  final String _apiKey = '32dac1cde066c3b3a3bb8f405be7e72b';
  final String _baseURL = 'api.themoviedb.org';
  final String _language = 'es_ES';

  List<TVSerie> onDisplaySeries = [];
  List<TVSerie> popularDisplaySeries = [];
  Map<int, List<Cast>> seriesCast = {};
  // ignore: prefer_final_fields
  int _popularPage = 0;

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  final StreamController<List<TVSerie>> _suggestioStreamController =
      new StreamController.broadcast();

  Stream<List<TVSerie>> get suggestionStream =>
      this._suggestioStreamController.stream;

  SeriesProvider() {
    this.getOnDisplaySeries();
    //this.getPopularSeries();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseURL, endpoint,
        {'api_key': _apiKey, 'languaje': _language, 'page': '$page'});
    final response = await http.get(url);
    return response.body;
  }

  void getOnDisplaySeries() async {
    final jsonData = await _getJsonData('3/series/now_playing');
    final tvPopularSeries = TvPopularSeries.fromJson(jsonData);
    onDisplaySeries = tvPopularSeries.results;
    notifyListeners();
  }
}
