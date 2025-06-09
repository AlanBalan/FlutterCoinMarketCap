import 'package:apicoinmarketcap_1/core/library/extensions.dart';
import 'package:apicoinmarketcap_1/data/datasouces/data_source.dart';
import 'package:apicoinmarketcap_1/domain/entities/core/http_response_entity.dart';
import 'package:apicoinmarketcap_1/domain/entities/moeda/moeda_entity.dart';

abstract interface class ImoedaRepository {

Future<List<Cripto>> getCripto();
}

final class Coin implements ImoedaRepository {
  final IRemoteDataSource _remoteDataSource;

  const Coin(this._remoteDataSource);

  @override
Future<List<Cripto>> getCripto() async {
  final HttpResponseEntity httpResponse = (await _remoteDataSource.get(_urlMoeda))!;

  final List<dynamic> lista = (httpResponse.data as Map<String, dynamic>)['data'];
  return lista.map((e) => Cripto.fromMap(e)).toList();
}

  String get _urlMoeda => _remoteDataSource.environment?.urlMoeda ?? '';  
} 