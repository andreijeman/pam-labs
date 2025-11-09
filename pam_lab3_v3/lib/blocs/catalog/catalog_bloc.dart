import 'package:bloc/bloc.dart';
import 'catalog_event.dart';
import 'catalog_state.dart';
import '../../models/catalog.dart';
import '../../models/section.dart';
import '../../repositories/catalog_repository.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final CatalogRepository repo;

  CatalogBloc(this.repo) : super(const CatalogState()) {
    on<CatalogEvent>((event, emit) async {
      if (event.type == 'start') {
        emit(state.copyWith(status: 'loading'));
        try {
          final data = await repo.load();
          emit(state.copyWith(status: 'success', catalog: data));
        } catch (e) {
          emit(state.copyWith(status: 'failure', error: e.toString()));
        }
      } else if (event.type == 'toggleFavorite' && state.catalog != null) {
        final c = state.catalog!;
        final updated = c.sections.map((s) {
          final items = s.items.map((p) => p.id == event.productId ? p.copyWith(isFavorite: !p.isFavorite) : p).toList();
          return Section(title: s.title, subtitle: s.subtitle, items: items);
        }).toList();
        emit(state.copyWith(catalog: Catalog(header: c.header, sections: updated)));
      }
    });
  }
}
