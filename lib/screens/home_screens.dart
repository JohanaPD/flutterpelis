import 'package:peliculas_flutter/screens/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:peliculas_flutter/providers/movies_provider.dart';
import 'package:peliculas_flutter/search/search_delegate.dart';
import 'package:peliculas_flutter/widgets/shakeable_dialog.dart';
import 'package:peliculas_flutter/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);
    return Scaffold(
      //crea menú hamburguesa
      drawer: Drawer(
        width: 250,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            //caja de imagen
            const DrawerHeader(
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(50),
                shape: BoxShape.circle,
                image:
                    DecorationImage(image: NetworkImage('assets/img/user.jpg')),
              ),
              child: Text('Administrar Perfiles',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
            ),
            ListTile(
              title: const Text('Cuenta'),
              leading: ElevatedButton(
                child: const Icon(Icons.person_2_outlined),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const HomeScreen(),
                  );
                },
              ),
            ),
            //Lista de titulos
            ListTile(
              title: const Text(
                'Configuración de la aplicación',
                textAlign: TextAlign.left,
                maxLines: 2,
                
              ),
              onTap: ()  => const ShakeableDialog(),
              leading: ElevatedButton(
                child: const Icon(Icons.settings_applications),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const ShakeableDialog(),
                  );
                },
              ),
            ),

            ListTile(
              title: const Text('Ayuda'),
               onTap: ()  => const ShakeableDialog(),
              leading: ElevatedButton(
                  child: const Icon(Icons.help_center),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => const ShakeableDialog(),
                    );
                  }),
            ),
            ListTile(
              title: const Text('Cerrar Sesión'),
              leading: ElevatedButton(
                  child: const Icon(Icons.closed_caption_disabled),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => const LoginScreen(),
                    );
                  }),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Películas en Cines',
            style: TextStyle(color: Colors.white)),
        elevation: 0,
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.search_outlined),
            onPressed: () =>
                showSearch(context: context, delegate: MovieSearchDelegate()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Tarjeta principales
            CardSwiperScreen(movies: moviesProvider.onDisplayMovies),
            //Slider de peliculas
            MovieSliderScreen(
                movies: moviesProvider.popularDisplayMovies,
                title: 'Populares',
                onNextPage: () => moviesProvider.getPopularMovies()),
          ],
        ),
      ),
    );
  }
}
