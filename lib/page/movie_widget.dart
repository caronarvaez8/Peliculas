import 'package:movie/provider/movie_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String? imagen= 'https://image.tmdb.org/t/p/original';

class MovieList extends StatefulWidget {

  _MovieListState createState() => _MovieListState();

}

class _MovieListState extends State<MovieList> {

  Widget build(BuildContext context) {
    MovieNotifier movieNotifier = Provider.of<MovieNotifier>(context);
    return   ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const PageScrollPhysics(),
      shrinkWrap: true,
      itemCount: movieNotifier.movieList.length,
      itemBuilder: (BuildContext context, int index) => new Card(
          color: Colors.blue.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.all(14),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Consumer<MovieNotifier>(
                          builder: (_, notifier, __) =>
                              Image.network('${imagen}${notifier.movieList[index].logo_path}')
                      ), Consumer<MovieNotifier>(
                        builder: (_, notifier, __) => Text(
                          "\n${notifier.movieList[index].name}",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: "OpenSans"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
