import 'package:dartz/dartz.dart';
import 'package:variacao_ativo/modules/home/domain/errors/errors.dart';
import 'package:variacao_ativo/modules/home/data/models/stocks_model.dart';

abstract class GetStocksRepository {
  Future<Either<StocksDataSourceError, StocksModel>> getStocks(String stock);
}
