import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import '../../../application/playlist/playlist_bloc.dart' as _i5;
import '../../../infrastructure/playlist_implement.dart' as _i4;
import '../../playlist/playlist_service.dart' as _i3;

_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.PlaylistService>(() => _i4.PlaylistImplement());
  gh.factory<_i5.PlaylistBloc>(
      () => _i5.PlaylistBloc(get<_i3.PlaylistService>()));
  return get;
}
