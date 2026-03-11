import 'package:week_8_future_repo/data/repositories/songs/song_repository_mock.dart';

void main() async {
  //   Instantiate the  song_repository_mock
  // Test both the success and the failure of the post request
  // Handle the Future using 2 ways  (2 tests)
  // - Using then() with .catchError().
  // - Using async/await with try/catch.

  final songRepoMock = SongRepositoryMock();

  //Using then() with .catchError()
  //fetchSongs - success case
  await songRepoMock
      .fetchSongs()
      .then((songs) {
        print('Success! Loaded ${songs.length} songs:');
        for (final song in songs) {
          print('=> ${song.title} by ${song.artist}');
        }
      })
      .catchError((error) {
        print('Error: $error');
      });

  // fetchSongById - success case
  await songRepoMock
      .fetchSongById('s1')
      .then((song) {
        print('Found song: ${song?.title} by ${song?.artist}');
      })
      .catchError((error) {
        print('Error: $error');
      });

  //fetchSongs - failure case
  songRepoMock.triesCount = 3;
  await songRepoMock
      .fetchSongs()
      .then((songs) {
        print('Success! Loaded ${songs.length} songs.');
      })
      .catchError((error) {
        print('Caught error: $error');
      });

  // fetchSongById - failure case
  await songRepoMock
      .fetchSongById('s25')
      .then((song) {
        print('Found song: ${song?.title}');
      })
      .catchError((error) {
        print('Caught error: $error');
      });

  //Using async/await with try/catch.
  //fetchSongs - success case
  songRepoMock.triesCount = 0;
  print('fetchSongs (should succeed):');
  try {
    final songs = await songRepoMock.fetchSongs();
    print('Success! Loaded ${songs.length} songs:');
    for (final song in songs) {
      print('  - ${song.title} by ${song.artist}');
    }
  } catch (e) {
    print('Error: $e');
  }

  // fetchSongById - success case
  try {
    final song = await songRepoMock.fetchSongById('s25');
    print('Found song: ${song?.title} by ${song?.artist}');
  } catch (e) {
    print('Error: $e');
  }

  //fetchSongs - failure case
  songRepoMock.triesCount = 3;
  print('\nfetchSongs (should fail):');
  try {
    final songs = await songRepoMock.fetchSongs();
    print('Success! Loaded ${songs.length} songs.');
  } catch (e) {
    print('Caught error: $e');
  }

  // fetchSongById - failure case
  try {
    final song = await songRepoMock.fetchSongById('s100');
    print('Found song: ${song?.title}');
  } catch (e) {
    print('Caught error: $e');
  }
}
