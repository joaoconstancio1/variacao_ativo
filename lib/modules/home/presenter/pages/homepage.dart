import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:variacao_ativo/modules/home/presenter/cubit/get_stocks_cubit.dart';
import 'package:variacao_ativo/modules/home/presenter/cubit/get_stocks_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();

    context.read<GetStocksCubit>().getStocks('PETR4.SA');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yahoo Finances'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Mostrando ações de PETR4",
            ),
            Table(
              border: TableBorder.all(color: Colors.black, width: 1.5),
              columnWidths: const {},
              children: const [
                TableRow(children: [
                  Text(
                    "Data",
                  ),
                  Text(
                    "Valor",
                  ),
                  Text(
                    "D-1",
                  ),
                  Text(
                    "V/Total",
                  ),
                ]),
              ],
            ),
            BlocConsumer<GetStocksCubit, GetStocksState>(
              listener: (context, state) {
                if (state is GetStocksErrorState) {
                  debugPrint('erro no estado');
                }
              },
              builder: (context, state) {
                if (state is GetStocksInitialState ||
                    state is GetStocksLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is GetStocksSuccessState) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount:
                            state.model.indicators?.quote?[0].close?.length,
                        itemBuilder: (context, index) {
                          _logic(state.model.timestamp,
                              state.model.indicators?.quote?[0].close);

                          return Table(
                            border: TableBorder.all(
                                color: Colors.black, width: 1.5),
                            columnWidths: const {},
                            children: [
                              TableRow(children: [
                                Text(
                                  tableData[index]['date'],
                                ),
                                Text(
                                  tableData[index]['value'].toStringAsFixed(2),
                                ),
                                Text(
                                  '${tableData[index]['dayChange'].toStringAsFixed(2)} %',
                                ),
                                Text(
                                  '${tableData[index]['overallChange'].toStringAsFixed(2)} %',
                                ),
                              ]),
                            ],
                          );
                        }),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> tableData = [];

  _logic(List<int>? timestamps, prices) {
    for (var i = 0; i < timestamps!.length; i++) {
      if (i == 0) {
        var dayChange = 0;
        var overallChange = 0;
        var currentDate =
            DateTime.fromMillisecondsSinceEpoch(timestamps[i] * 1000);
        var currentPrice = prices[i];

        tableData.add({
          'date': '${currentDate.day}/${currentDate.month}/${currentDate.year}',
          'value': currentPrice,
          'dayChange': dayChange,
          'overallChange': overallChange,
        });
      } else {
        var currentDate =
            DateTime.fromMillisecondsSinceEpoch(timestamps[i] * 1000);
        var currentPrice = prices[i];
        var previousPrice = prices[i - 1];
        var dayChange = (currentPrice - previousPrice) / previousPrice * 100;
        var overallChange = (currentPrice - prices[0]) / prices[0] * 100;

        tableData.add({
          'date': '${currentDate.day}/${currentDate.month}/${currentDate.year}',
          'value': currentPrice,
          'dayChange': dayChange,
          'overallChange': overallChange,
        });
      }
    }
  }
}
