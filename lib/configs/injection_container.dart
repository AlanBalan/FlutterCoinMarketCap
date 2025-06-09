import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:apicoinmarketcap_1/configs/environment_helper.dart';
import 'package:apicoinmarketcap_1/core/service/IApp_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
  final IEnvironmentHelper environmentHelper = EnvironmentHelper();
  getIt.registerSingleton<IEnvironmentHelper>(environmentHelper);

  getIt.registerSingleton<IAppService>(AppService(GlobalKey<NavigatorState>()));
}