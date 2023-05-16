import 'package:injectable/injectable.dart';
import 'package:muzikplaya/core/constants.dart';
import 'package:muzikplaya/domain/playlist/playlist_service.dart';
import 'package:muzikplaya/splash.dart';

@LazySingleton(as: PlaylistService)
class PlaylistImplement implements PlaylistService {
  @override
  Future<List<String>> createPlaylistNames({required String plylstName}) async {
    List<String> _playlistNames = [];
    _playlistNames.addAll(dbBox.get(plylstlisting)!.cast<String>());
    _playlistNames.add(plylstName);
    await dbBox.put(plylstlisting, _playlistNames);
    return _playlistNames;
  }
}
