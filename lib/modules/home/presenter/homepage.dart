import 'package:flutter/material.dart';
import 'package:variacao_ativo/modules/home/domain/stocks_model.dart';
import 'package:variacao_ativo/modules/home/external/stocks_ext.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StocksModel? stocks;

  initState() {
    super.initState();
    _getStocks();
  }

  _getStocks() async {
    final result = await StocksExternal().getStocks();

    setState(() {
      stocks = result;
    });
    print(result);
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
        child: stocks == null
            ? CircularProgressIndicator()
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: stocks?.indicators?.quote?[0].close?.length,
                itemBuilder: (context, index) {
                  _logic(
                      stocks?.timestamp, stocks?.indicators?.quote?[0].close);

                  return Column(
                    children: [
                      // Text(
                      //     '${DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000)}'),
                      // Text(
                      //     '${stocks?.indicators?.quote?[0].close?[index].toStringAsFixed(2)}/'),
                      Text(tableData[index]['Data']),
                      Text(tableData[index]['Valor do ativo']
                          .toStringAsFixed(2)),
                      Text(tableData[index]['Variação diária']
                          .toStringAsFixed(2)),
                      Text(tableData[index]['Variação total']
                          .toStringAsFixed(2)),
                    ],
                  );
                }),
      ),
    );
  }

  List<Map<String, dynamic>> tableData = [];

  _logic(List<int>? timestamps, prices) {
    for (var i = 1; i < timestamps!.length; i++) {
      var firstPrice = prices[0];

      var currentDate =
          DateTime.fromMillisecondsSinceEpoch(timestamps[i] * 1000);
      var previousDate =
          DateTime.fromMillisecondsSinceEpoch(timestamps[i - 1] * 1000);
      var currentPrice = prices[i];
      var previousPrice = prices[i - 1];
      var dayChange = (currentPrice - previousPrice) / previousPrice * 100;
      var overallChange = (currentPrice - firstPrice) / firstPrice * 100;

      tableData.add({
        'Data': '${currentDate.day}/${currentDate.month}/${currentDate.year}',
        'Valor do ativo': currentPrice,
        'Variação diária': dayChange,
        'Variação total': overallChange,
      });
    }
  }
}
