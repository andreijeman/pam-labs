
import '../entities/feed.dart';

abstract class FeedRepository {
  Future<Feed> getFeed();
}