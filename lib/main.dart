import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/watchlist/bloc/watchlist_bloc.dart';
import 'features/watchlist/bloc/watchlist_event.dart';
import 'features/watchlist/repository/watchlist_repository.dart';
import 'features/watchlist/presentation/screens/watchlist_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '021 Trade',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sans',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Color(0xFF1A1A1A),
          ),
          titleTextStyle: TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: BlocProvider(
        create: (context) => WatchlistBloc(
          repository: WatchlistRepository(),
        )..add(const LoadWatchlist('Watchlist 1')),
        child: const WatchlistScreen(),
      ),
    );
  }
}