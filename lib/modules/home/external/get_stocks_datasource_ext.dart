import 'package:dio/dio.dart';
import 'package:variacao_ativo/modules/home/data/datasource/get_stocks_datasource.dart';
import 'package:variacao_ativo/modules/home/data/models/stocks_model.dart';

class GetStocksDatasourceExt implements GetStocksDatasource {
  @override
  Future<StocksModel> getStocks() async {
    const symbol = 'PETR4.SA';
    const url =
        'https://query2.finance.yahoo.com/v8/finance/chart/$symbol?interval=1d&range=1mo';

    final response = await Dio().get(url);
    final data = response.data['chart']['result'][0];
    final result = StocksModel.fromJson(data);
    return result;
  }
}
