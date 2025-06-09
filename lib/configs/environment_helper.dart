abstract interface class IEnvironmentHelper {
  String? get urlMoeda;
  String? get urlMoedasimbolo;
}

final class EnvironmentHelper implements IEnvironmentHelper {
  const EnvironmentHelper();

  String get _urlBase => 'https://pro-api.coinmarketcap.com';

  @override
  String? get urlMoeda => '$_urlBase/v1/cryptocurrency/listings/latest';
  
  @override
  String? get urlMoedasimbolo => '$_urlBase/v1/cryptocurrency/quotes/latest?symbol=';
}

final String apiKey = '4b5d3463-bd33-4895-952f-380e5fd744c5';