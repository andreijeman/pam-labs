import '../../domain/entities/feed.dart';
import '../../domain/repositories/feed_repository.dart';
import '../datasources/feed_remote_data_source.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSource remoteDataSource;

  FeedRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Feed> getFeed() async {
    final model = await remoteDataSource.getFeed();
    return model.toEntity();
  }
}