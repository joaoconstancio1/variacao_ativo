import 'package:dio/dio.dart';
import 'package:variacao_ativo/modules/home/data/datasource/get_stocks_datasource.dart';
import 'package:variacao_ativo/modules/home/data/models/stocks_model.dart';
import 'package:variacao_ativo/modules/home/domain/errors/errors.dart';
import 'package:variacao_ativo/shared/error_body_model.dart';

class GetStocksDatasourceExt implements GetStocksDatasource {
  final Dio dio;

  GetStocksDatasourceExt(this.dio);

  @override
  Future<StocksModel> getStocks(String stock) async {
    final url =
        'https://query2.finance.yahoo.com/v8/finance/chart/$stock?interval=1d&range=1mo';

    try {
      final response = await dio.get(url);
      final data = response.data['chart']['result'][0];
      final result = StocksModel.fromJson(data);
      if (response.statusCode == 200) {
        return result;
      } else {
        throw StocksDataSourceError(message: response.statusMessage);
      }
    } on DioError catch (e) {
      var error = ErrorBody.fromMap(e.response?.data);
      throw StocksDataSourceError(
        message: error.message,
        action: error.action,
      );
    } catch (e) {
      throw StocksDataSourceError(
        message: 'Generic Error',
      );
    }
  }
}
