import 'package:flutter/material.dart';
import 'package:peliculas_flutter/models/models.dart';
import 'package:peliculas_flutter/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar Película';

  Widget _emptyContainer() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: const Center(
        child: Icon(Icons.movie_creation_outlined,
            color: Colors.black38, size: 100),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('BuildResult');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData)return _emptyContainer();
        
        final movies = snapshot.data!;

        // for(var i=0; i<=movies.length; i++){
        //   print(movies[i]);
        // }

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItem(movies[index]),
        );
      },
    );
  }
}

// ignore: unused_element
class _MovieItem extends StatelessWidget {
  final Movie movie;
  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    movie.heroId='search-${movie.id}';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: const AssetImage('assets/img/no-image.jpg'),
          image: NetworkImage(movie.fullPosterImg),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle:Text(movie.originalTitle),
      onTap:() {
        Navigator.pushNamed(context, 'details', arguments:movie);
      }, 
    );
  }
}
