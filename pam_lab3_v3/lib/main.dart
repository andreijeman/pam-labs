import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/home_page.dart';
import 'theme.dart';

import 'blocs/catalog/catalog_bloc.dart';
import 'blocs/catalog/catalog_event.dart';
import 'repositories/catalog_repository.dart';

void main() {
  runApp(const StreetClothesApp());
}

class StreetClothesApp extends StatelessWidget {
  const StreetClothesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CatalogBloc(CatalogRepository('assets/catalog.json'))
            ..add(const CatalogEvent.start()),
        ),
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
