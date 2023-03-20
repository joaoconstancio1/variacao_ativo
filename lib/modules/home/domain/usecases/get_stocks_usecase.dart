import 'package:dartz/dartz.dart';
import 'package:variacao_ativo/modules/home/domain/errors/errors.dart';
import 'package:variacao_ativo/modules/home/domain/repositories/get_stocks_repository.dart';
import 'package:variacao_ativo/modules/home/data/models/stocks_model.dart';

abstract class GetStocksUsecase {
  Future<Either<StocksDataSourceError, StocksModel>> call(String stock);
}

class GetStocksUsecaseImpl implements GetStocksUsecase {
  final GetStocksRepository repository;

  GetStocksUsecaseImpl(this.repository);

  @override
  Future<Either<StocksDataSourceError, StocksModel>> call(String stock) {
    return repository.getStocks(stock);
  }
}
