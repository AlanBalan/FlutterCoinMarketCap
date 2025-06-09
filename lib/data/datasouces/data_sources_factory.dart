import 'package:apicoinmarketcap_1/configs/environment_helper.dart';
import 'package:apicoinmarketcap_1/configs/injection_container.dart';
import 'package:apicoinmarketcap_1/core/service/http_service.dart';
import 'package:apicoinmarketcap_1/data/datasouces/data_source.dart';
import 'package:apicoinmarketcap_1/data/datasouces/remote_datasource.dart';

final class RemoteFactoryDataSource {
  IRemoteDataSource create() {
    final IHttpService httpService = HttpServiceFactory().create();
    final IEnvironmentHelper environmentHelper = getIt<IEnvironmentHelper>();
    return RemoteDataSource(
      httpService, 
      environmentHelper, 
    );
  }
}