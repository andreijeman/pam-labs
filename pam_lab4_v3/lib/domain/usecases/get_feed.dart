import '../entities/feed.dart';
import '../repositories/feed_repository.dart';

class GetFeed {
  final FeedRepository repository;

  GetFeed(this.repository);

  Future<Feed> call() {
    return repository.getFeed();
  }
}