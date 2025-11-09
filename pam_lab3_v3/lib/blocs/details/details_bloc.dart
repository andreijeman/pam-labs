import 'package:bloc/bloc.dart';
import 'details_event.dart';
import 'details_state.dart';
import '../../repositories/details_repository.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final DetailsRepository repo;

  DetailsBloc(this.repo) : super(const DetailsState()) {
    on<DetailsEvent>((event, emit) async {
      switch (event.type) {
        case 'start':
          emit(state.copyWith(status: 'loading'));
          try {
            final data = await repo.load();
            emit(state.copyWith(status: 'success', data: data));
          } catch (e) {
            emit(state.copyWith(status: 'failure', error: e.toString()));
          }
          break;
        case 'color':
          emit(state.copyWith(colorIndex: event.index, imageIndex: 0));
          break;
        case 'image':
          emit(state.copyWith(imageIndex: event.index));
          break;
        case 'size':
          emit(state.copyWith(sizeIndex: event.index));
          break;
        case 'wishlist':
          emit(state.copyWith(wishlisted: !state.wishlisted));
          break;
      }
    });
  }
}
