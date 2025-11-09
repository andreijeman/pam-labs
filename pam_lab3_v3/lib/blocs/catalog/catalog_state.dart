import '../../models/catalog.dart';

class CatalogState {
  final String status; // 'initial' | 'loading' | 'success' | 'failure'
  final Catalog? catalog;
  final String? error;

  const CatalogState({this.status = 'initial', this.catalog, this.error});

  CatalogState copyWith({String? status, Catalog? catalog, String? error}) =>
      CatalogState(status: status ?? this.status, catalog: catalog ?? this.catalog, error: error);
}
