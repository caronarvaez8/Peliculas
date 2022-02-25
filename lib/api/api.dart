import 'dart:convert';
import 'package:movie/page/movie_widget.dart';
import 'package:movie/provider/movie_notifier.dart';
import 'package:movie/models/movies.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';



String url1 = "api.themoviedb.org";
String url2 = "3/movie/550";

late AnimationController _controller;

class Movie extends StatefulWidget {
  @override


  _MovieState createState() => _MovieState();

}

class _MovieState extends State<Movie> with TickerProviderStateMixin {


  Widget build(BuildContext context) {

    MovieNotifier movieNotifier = Provider.of<MovieNotifier>(context);
    double widthApp = MediaQuery.of(context).size.width;
    double heightApp = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text("Peliculas", textAlign: TextAlign.left,),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],

        ),
        backgroundColor: Color(0xFFFCF6F6),
        body: SingleChildScrollView(
            child: Stack(
                fit: StackFit.loose,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: (heightApp * 0.1)),
                                child: Text("Quieres saber que peliculas tenemos",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "OpenSans_SemiBold",
                                        fontSize: 18)),
                              ),
                              new Container(
                                  padding: EdgeInsets.only(top: (heightApp * 0.08)),
                                  child: ElevatedButton(
                                    child: Text("Buscar",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "OpenSans_SemiBold",
                                            fontSize: 18)),
                                    onPressed: () async {
                                      movieNotifier.listMovie();
                                    },
                                  )
                              ),
                            ]),
                      ),
                    ],
                  ),
                  new Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top:220),
                      child: Row(
                          children: <Widget>[
                            Expanded(
                                child: MovieList())
                          ])
                  ),
                ])
        )
    );
  }
}


Future<List<Movies>> getMovie() async {
  var queryParameters = <String, dynamic>{
    'api_key': 'e63b2e0d15add4c3c079242b8c147a97',
  };
  List<Movies> movie = [];
  var uri = Uri.https(url1, url2, queryParameters);
  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> decoded = new Map<String, dynamic>.from(jsonDecode(response.body));

      for (var i = 0; i < 6; i++) {
        Movies aux = Movies.fromJson(decoded["production_companies"][i]);
        movie.add(aux);
      }
      print(decoded["production_companies"][1]['logo_path']);
      return movie;
    } else {
      return Future.error("error este");
    }
  } catch (e) {
    return Future.error(e);
  }
}