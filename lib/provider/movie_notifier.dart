import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:movie/api/api.dart';
import 'package:movie/models/movies.dart';

class MovieNotifier with ChangeNotifier {
  List<Movies> _movieList = [];

  UnmodifiableListView<Movies> get movieList => UnmodifiableListView(_movieList);

  addMovie(Movies movie) {
    _movieList.add(movie);
    notifyListeners();
  }

  listMovie() {
    getMovie().then((value) {
      _movieList.addAll(value);
      notifyListeners();
    }).catchError((onError) {
      print(onError);
    });
  }
}