import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:variacao_ativo/modules/home/domain/errors/errors.dart';
import 'package:variacao_ativo/modules/home/domain/usecases/get_stocks_usecase.dart';
import 'package:variacao_ativo/modules/home/presenter/cubit/get_stocks_states.dart';

class GetStocksCubit extends Cubit<GetStocksState> {
  final GetStocksUsecase _usecase;

  GetStocksCubit(this._usecase) : super(GetStocksInitialState());

  void getStocks() async {
    emit(const GetStocksLoadingState(true));
    final result = await _usecase();

    result.fold(
      (l) => emit(
          GetStocksErrorState(StocksDataSourceError(message: 'Generic Error'))),
      (r) {
        emit(GetStocksSuccessState(r));
      },
    );
  }
}
