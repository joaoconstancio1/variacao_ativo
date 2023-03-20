import 'package:equatable/equatable.dart';
import 'package:variacao_ativo/modules/home/data/models/stocks_model.dart';
import 'package:variacao_ativo/modules/home/domain/errors/errors.dart';

abstract class GetStocksState extends Equatable {
  const GetStocksState();
}

class GetStocksInitialState extends GetStocksState {
  @override
  List<Object> get props => [];
}

class GetStocksLoadingState extends GetStocksState {
  final bool prop;

  const GetStocksLoadingState(this.prop);

  @override
  List<Object> get props => [prop];
}

class GetStocksSuccessState extends GetStocksState {
  const GetStocksSuccessState(
    this.model,
  );

  final StocksModel model;

  @override
  List<Object> get props => [model];
}

class GetStocksErrorState extends GetStocksState {
  const GetStocksErrorState(
    this.failure,
  );

  final StocksDataSourceError failure;

  @override
  List<Object> get props => [failure];
}
