// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_flutter/helpers/Debouncer.dart';
import 'package:peliculas_flutter/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  String _apiKey = '32dac1cde066c3b3a3bb8f405be7e72b';
  // ignore: prefer_final_fields
  String _baseURL = 'api.themoviedb.org';
  // ignore: prefer_final_fields
  String _language = 'es_ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularDisplayMovies = [];
  Map<int, List<Cast>> moviesCast = {};
  int _popularPage = 0;

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));
  // ignore: unnecessary_new
  final StreamController<List<Movie>> _suggestioStreamController =
      // ignore: unnecessary_new
      new StreamController.broadcast();
  // ignore: unnecessary_this
  Stream<List<Movie>> get suggestionStream =>
      // ignore: unnecessary_this
      this._suggestioStreamController.stream;

  MoviesProvider() {
    // ignore: unnecessary_this
    this.getOnDisplayMovies();
    // ignore: unnecessary_this
    this.getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseURL, endpoint,
        {'api_key': _apiKey, 'languaje': _language, 'page': '$page'});
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditResponse.cast;
    return creditResponse.cast;
  }

  getPopularMovies() async {
    //dominio
    // var url = Uri.https(_baseURL, '3/movie/popular',
    //     {'api_key': _apiKey, 'languaje': _language, 'page': '1'});
    // final response = await http.get(url);
    // final popularResponse = PopularResponse.fromJson(response.body);
    // // final Map <String, dynamic> decodedData = json.decode(response.body);
    // if (response.statusCode != 200) return print('error');
    // //print(nowPlayingResponse.results[0].title);
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularDisplayMovies = [
      ...popularDisplayMovies,
      ...popularResponse.results
    ];
    notifyListeners();
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseURL, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final results = await searchMovie(value);
      _suggestioStreamController.add(results);
    };
    // ignore: unused_local_variable
    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
