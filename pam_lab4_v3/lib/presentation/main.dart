import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../data/datasources/feed_remote_data_source.dart';
import '../data/repositories/feed_repository_impl.dart';
import '../domain/usecases/get_feed.dart';
import 'blocs/feed_bloc.dart';
import 'theme.dart';
import 'widgets/home_page.dart';

void main() {
  runApp(const StreetClothesApp());
}

class StreetClothesApp extends StatelessWidget {
  const StreetClothesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Simple manual wiring (you can move this to a DI container later)
    final httpClient = http.Client();
    final feedRemoteDataSource =
        FeedRemoteDataSourceImpl(client: httpClient);
    final feedRepository =
        FeedRepositoryImpl(remoteDataSource: feedRemoteDataSource);
    final getFeed = GetFeed(feedRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedBloc>(
          create: (_) => FeedBloc(getFeed)..add(const LoadFeed()),
        ),
        // ProductDetailsBloc is provided inside ProductDetailPage,
        // so we don't register it globally here.
      ],
      child: MaterialApp(
        title: 'Street Clothes',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const HomePage(),
      ),
    );
  }
}
