import 'package:variacao_ativo/modules/home/data/models/stocks_model.dart';

abstract class GetStocksDatasource {
  Future<StocksModel> getStocks();
}
