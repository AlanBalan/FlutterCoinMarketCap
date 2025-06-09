import 'package:apicoinmarketcap_1/configs/environment_helper.dart';
import 'package:apicoinmarketcap_1/core/library/extensions.dart';
import 'package:apicoinmarketcap_1/data/datasouces/data_source.dart';
import 'package:apicoinmarketcap_1/domain/entities/core/http_response_entity.dart';
import 'package:apicoinmarketcap_1/domain/entities/moeda/moeda_entity.dart';

abstract interface class ImoedabuscaRepository {
  Future<List<Cripto>> getCriptoMoedasymbol(List<String> simbolos);
}

final class searchCoin implements ImoedabuscaRepository {
  final IRemoteDataSource _remoteDataSource;
  final IEnvironmentHelper _environment;

  const searchCoin(this._remoteDataSource, this._environment);

  @override
  Future<List<Cripto>> getCriptoMoedasymbol(List<String> simbolos) async {
    final url = urlSimbol(simbolos, _environment);
    final HttpResponseEntity httpResponse = (await _remoteDataSource.get(url))!;

    final Map<String, dynamic> dados = httpResponse.data as Map<String, dynamic>;
    final List<Cripto> coin = [];

    dados['data'].forEach((symbol, item) {
      coin.add(Cripto.fromMap(item));
    });

    return coin;
  }
}

String urlSimbol(List<String> simbolos, IEnvironmentHelper environment) {
  final simbolosFormatados = simbolos.map((e) => e.trim().toUpperCase()).join(',');
  return '${environment.urlMoedasimbolo}$simbolosFormatados';
}