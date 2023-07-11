import 'package:danbooru_dart/danbooru_dart.dart';
import 'package:test/test.dart';

void main() {
  test('Random', () async {
    final String host = 'danbooru.donmai.us';

    final client = DanbooruClient(host);

    final posts = await client.getPostsRandom(tags: ['anal']);

    if (posts == null) {
      throw 'Posts is null';
    }

    expect(posts, isNotNull);
  });

  test('Count Posts', () async {
    final String host = 'danbooru.donmai.us';

    final client = DanbooruClient(host);

    final count = await client.getPostsCounts(tags: ['anal']);

    print(count);

    expect(count, isNotNull);
  });

  test('Max Page', () async {
    final String host = 'danbooru.donmai.us';

    final client = DanbooruClient(host);

    final maxPage = await client.getMaxPage(tags: ['anal']);

    print(maxPage);

    final posts = await client.getPosts(tags: ['anal'], page: maxPage);

    print(posts.length);

    expect(posts, isNotNull);
  });
}
