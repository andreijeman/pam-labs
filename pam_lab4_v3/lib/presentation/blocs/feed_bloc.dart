import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/feed.dart';
import '../../../domain/usecases/get_feed.dart';

/// EVENTS

abstract class FeedEvent extends Equatable {
  const FeedEvent();

  @override
  List<Object?> get props => [];
}

class LoadFeed extends FeedEvent {
  const LoadFeed();
}

class RefreshFeed extends FeedEvent {
  const RefreshFeed();
}

/// STATES

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object?> get props => [];
}

class FeedInitial extends FeedState {
  const FeedInitial();
}

class FeedLoading extends FeedState {
  const FeedLoading();
}

class FeedLoaded extends FeedState {
  final Feed feed;

  const FeedLoaded(this.feed);

  @override
  List<Object?> get props => [feed];
}

class FeedError extends FeedState {
  final String message;

  const FeedError(this.message);

  @override
  List<Object?> get props => [message];
}

/// BLOC

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeed getFeed;

  FeedBloc(this.getFeed) : super(const FeedInitial()) {
    on<LoadFeed>(_onLoadFeed);
    on<RefreshFeed>(_onRefreshFeed);
  }

  Future<void> _onLoadFeed(
    LoadFeed event,
    Emitter<FeedState> emit,
  ) async {
    emit(const FeedLoading());
    try {
      final feed = await getFeed();
      emit(FeedLoaded(feed));
    } catch (e) {
      emit(FeedError(e.toString()));
    }
  }

  Future<void> _onRefreshFeed(
    RefreshFeed event,
    Emitter<FeedState> emit,
  ) async {
    // Optionally keep current data while refreshing
    final previousState = state;

    if (previousState is! FeedLoaded) {
      emit(const FeedLoading());
    }

    try {
      final feed = await getFeed();
      emit(FeedLoaded(feed));
    } catch (e) {
      // If we had data, we might want to keep it and show an error elsewhere,
      // but to keep it simple we emit FeedError here.
      emit(FeedError(e.toString()));
    }
  }
}