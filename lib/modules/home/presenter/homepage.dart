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
            : Column(
                children: [
                  Table(
                    border: TableBorder.all(color: Colors.black, width: 1.5),
                    columnWidths: const {},
                    children: const [
                      TableRow(children: [
                        Text(
                          "Data",
                          style: TextStyle(fontSize: 15.0),
                        ),
                        Text(
                          "Valor",
                          style: TextStyle(fontSize: 15.0),
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
                  Expanded(
                    child: ListView.builder(
                        itemCount: stocks?.indicators?.quote?[0].close?.length,
                        itemBuilder: (context, index) {
                          _logic(stocks?.timestamp,
                              stocks?.indicators?.quote?[0].close);

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
