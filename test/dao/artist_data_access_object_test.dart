import 'package:danbooru_dart/danbooru_dart.dart';
import 'package:http/http.dart';
import 'package:sha_env/sha_env.dart';
import 'package:test/test.dart';

void main() async {
  late DanbooruClient client;

  setUpAll(() async {
    await load();

    client = DanbooruClient('testbooru.donmai.us',
        username: env['USERNAME'], apiKey: env['KEY']);
  });

  group('Testing [Artist] DAO', () {
    test('index method', () async {
      final artists = await client.artists.index();

      expect(artists, isNotNull);
      expect(artists, isA<List<Artist>>());
    });

    test('create method', () async {
      final Artist newArtist = Artist('exampleName',
          groupName: 'exampleGroupName', isBanned: false, isDeleted: false);

      Artist? createdArtist;

      try {
        createdArtist = await client.artists.create(newArtist);
      } on ClientException catch (e) {
        print(e.message);
        fail('Client exception thrown');
      }
      expect(createdArtist, isNotNull);
      expect(createdArtist, isA<Artist>());
      expect(createdArtist.name.toLowerCase(), equals(newArtist.name));
      expect(createdArtist.id, greaterThan(0));
    });

    group('Specific tests', () {
      test('Find shalien as artist using name', () async {
        final artists = await client.artists.index(name: 'shalien');

        expect(artists, isEmpty);
      });
    });
  });
}
