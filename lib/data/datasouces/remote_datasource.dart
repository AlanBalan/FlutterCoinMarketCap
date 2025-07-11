import 'package:apicoinmarketcap_1/configs/environment_helper.dart';
import 'package:apicoinmarketcap_1/core/service/http_service.dart';
import 'package:apicoinmarketcap_1/data/datasouces/data_source.dart';
import 'package:apicoinmarketcap_1/domain/entities/core/http_response_entity.dart';

base class RemoteDataSource implements IRemoteDataSource {
  final IHttpService _http;
  final IEnvironmentHelper _environment;

  const RemoteDataSource(this._http, this._environment,);

@override
Future<HttpResponseEntity> get(String url, [String? token]) async {
  try {
    return await _http.get(url);
  } catch (_) {
    rethrow;
  }
}

  @override
  Future<HttpResponseEntity?> post(String url, [String? data]) async {
    try {
      return await _http.post(url, data: data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity?> put(String url, [String? data]) async {
    try {
      return await _http.put(url, data: data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity?> patch(String url, [String? data]) async {
    try {
      return await _http.patch(url, data: data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<HttpResponseEntity?> delete(String url, [String? data]) async {
    try {
      return await _http.delete(url, data: data);
    } catch (_) {
      rethrow;
    }
  }

  @override
  IEnvironmentHelper get environment => _environment;
}