import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:projectuts/controllers/coin_controllers.dart';
import 'package:projectuts/models/coin_model.dart';

class CoinChartScreen extends StatefulWidget {
  final Coin coin;

  const CoinChartScreen({super.key, required this.coin});

  @override
  _CoinChartScreenState createState() => _CoinChartScreenState();
}

class _CoinChartScreenState extends State<CoinChartScreen> {
  late Future<List<FlSpot>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = Get.find<CoinController>().fetchCoinHistory(widget.coin.id);
  }

  String _formatYAxisLabel(double value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    } else {
      return value.toStringAsFixed(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.coin.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          FutureBuilder<List<FlSpot>>(
            future: _futureData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: 400, // Set height to prevent overflow
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      _formatYAxisLabel(value),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 12),
                                    ),
                                  );
                                },
                                reservedSize: 40,
                              ),
                            ),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(color: Colors.black, width: 1),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: snapshot.data!,
                              isCurved: true,
                              color: Colors.blue,
                              barWidth: 2,
                              isStrokeCapRound: true,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(show: false),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'CHART 3 HARI YANG LALU',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
