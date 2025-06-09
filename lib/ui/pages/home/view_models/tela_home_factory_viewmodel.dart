import 'package:apicoinmarketcap_1/configs/factory_viewmodel.dart';
import 'package:apicoinmarketcap_1/data/datasouces/data_source.dart';
import 'package:apicoinmarketcap_1/data/datasouces/data_sources_factory.dart';
import 'package:apicoinmarketcap_1/data/repositories/buscarmoeda.dart';
import 'package:apicoinmarketcap_1/data/repositories/pegarmoeda.dart';
import 'package:apicoinmarketcap_1/ui/pages/home/view_models/tela_home_viewmodel.dart';
import 'package:flutter/material.dart';

final class TelaPerfilFactoryViewmodel implements IFactoryViewModel<TelaHomeViewModel> {
  @override
  TelaHomeViewModel create(BuildContext context) {
    final IRemoteDataSource remoteDataSource = RemoteFactoryDataSource().create();
    final IEnvironmentHelper environmentHelper = const EnvironmentHelper();

    final ImoedabuscaRepository buscaRepository = searchCoin(remoteDataSource, environmentHelper);
    final ImoedaRepository moedaRepository = Coin(remoteDataSource);
    
    return TelaHomeViewModel(moedaRepository,buscaRepository);
  }

  @override
  void dispose(BuildContext context, TelaHomeViewModel viewModel) {
    viewModel.close();
  }
}