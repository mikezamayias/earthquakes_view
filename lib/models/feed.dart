import 'package:http/http.dart' as http;
import 'package:webfeed/domain/rss_feed.dart';

class Feed {
  final String url;
  late RssFeed data;

  Feed(
    this.url,
  ) : super();

  Future<void> load() async {
    String rss;
    rss = await http.read(Uri.parse(url));
    data = new RssFeed.parse(rss);
  }

  @override
  String toString() => 'Feed(url: $url, data: $data)';
}
