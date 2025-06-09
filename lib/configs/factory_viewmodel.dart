import 'package:flutter/material.dart';
export 'package:flutter/material.dart';
export 'package:apicoinmarketcap_1/configs/environment_helper.dart';
export 'package:apicoinmarketcap_1/configs/injection_container.dart';
export 'package:apicoinmarketcap_1/data/datasouces/data_source.dart';

abstract interface class IFactoryViewModel<T> {
  T create(BuildContext context);
  void dispose(BuildContext context, T viewModel);
}