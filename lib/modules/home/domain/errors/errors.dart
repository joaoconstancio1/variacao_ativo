abstract class FailureStocks implements Exception {}

class StocksDataSourceError implements FailureStocks {
  final String? message;
  final String? action;

  StocksDataSourceError({this.message, this.action});
}
