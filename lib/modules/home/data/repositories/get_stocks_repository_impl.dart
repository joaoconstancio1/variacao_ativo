import 'package:dartz/dartz.dart';
import 'package:variacao_ativo/modules/home/data/datasource/get_stocks_datasource.dart';
import 'package:variacao_ativo/modules/home/data/models/stocks_model.dart';
import 'package:variacao_ativo/modules/home/domain/errors/errors.dart';
import 'package:variacao_ativo/modules/home/domain/repositories/get_stocks_repository.dart';

class GetStocksRepositoryImpl implements GetStocksRepository {
  final GetStocksDatasource datasource;

  GetStocksRepositoryImpl(this.datasource);

  @override
  Future<Either<StocksDataSourceError, StocksModel>> getStocks() async {
    try {
      final result = await datasource.getStocks();
      return Right(result);
    } on StocksDataSourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(StocksDataSourceError(message: '', action: ''));
    }
  }
}
