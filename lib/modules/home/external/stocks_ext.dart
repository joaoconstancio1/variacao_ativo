import 'package:dio/dio.dart';
import 'package:variacao_ativo/modules/home/domain/stocks_model.dart';

class StocksExternal {
  Future<StocksModel> getStocks() async {
    const symbol = 'PETR4.SA';
    const url =
        'https://query2.finance.yahoo.com/v8/finance/chart/$symbol?interval=1d&range=1mo';

    final response = await Dio().get(url);
    final data = response.data['chart']['result'][0];
    final prices = data['indicators']['quote'][0]['close'];
    final result = StocksModel.fromJson(data);
    print(result);
    return result;
  }
}
