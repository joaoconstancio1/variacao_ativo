import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:variacao_ativo/modules/home/domain/usecases/get_stocks_usecase.dart';
import 'package:variacao_ativo/modules/home/domain/usecases/get_stocks_usecase.dart';
import 'package:variacao_ativo/modules/home/external/get_stocks_datasource_ext.dart';

import 'modules/home/data/repositories/get_stocks_repository_impl.dart';
import 'modules/home/presenter/cubit/get_stocks_cubit.dart';
import 'modules/home/presenter/pages/homepage.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => GetStocksCubit(i())),
    Bind((i) => GetStocksUsecaseImpl(i())),
    Bind((i) => GetStocksRepositoryImpl(i())),
    Bind((i) => GetStocksDatasourceExt()),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => BlocProvider.value(
            value: Modular.get<GetStocksCubit>(),
            child: HomePage(),
          ),
        ),
      ];
}
