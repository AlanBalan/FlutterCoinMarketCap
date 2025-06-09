import 'package:apicoinmarketcap_1/configs/injection_container.dart' as injector;
import 'package:apicoinmarketcap_1/core/service/IApp_service.dart';
import 'package:apicoinmarketcap_1/ui/pages/home/home_Page.dart';
import 'package:apicoinmarketcap_1/ui/pages/home/view_models/tela_home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await injector.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: injector.getIt<IAppService>().navigatorKey,

      title: 'CriptoAPP',
      debugShowCheckedModeBanner: false,
      home: BlocProvider<TelaHomeViewModel>(
        create: (context) => injector.getIt<TelaHomeViewModel>(),
        child: const HomePage(),
    )
    );
  }
}