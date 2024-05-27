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
  int _selectedInterval = 1;

  @override
  void initState() {
    super.initState();
    _futureData = Get.find<CoinController>().fetchCoinHistory(widget.coin.id, _selectedInterval);
  }

  void _updateChart(int interval) {
    setState(() {
      _selectedInterval = interval;
      _futureData = Get.find<CoinController>().fetchCoinHistory(widget.coin.id, _selectedInterval);
    });
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coin.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              widget.coin.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIntervalButton(1, '1 Hari'),
                _buildIntervalButton(3, '3 Hari'),
                _buildIntervalButton(5, '5 Hari'),
                _buildIntervalButton(7, '7 Hari'),
              ],
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
                        height: 400,
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: true,
                              getDrawingVerticalLine: (value) {
                                return const FlLine(
                                  color: Colors.grey,
                                  strokeWidth: 1,
                                );
                              },
                              drawHorizontalLine: true,
                              getDrawingHorizontalLine: (value) {
                                return const FlLine(
                                  color: Colors.grey,
                                  strokeWidth: 1,
                                );
                              },
                            ),
                            titlesData: FlTitlesData(
                              bottomTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    return Padding(
                                      padding: const EdgeInsets.all(3.0),
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
                                color: const Color.fromARGB(255, 255, 0, 0),
                                barWidth: 2,
                                isStrokeCapRound: true,
                                dotData: const FlDotData(show: true),
                                belowBarData: BarAreaData(show: true),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'CHART $_selectedInterval HARI YANG LALU',
                        style: const TextStyle(fontSize: 12, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntervalButton(int interval, String text) {
    return ElevatedButton(
      onPressed: () => _updateChart(interval),
      child: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedInterval == interval ? Colors.blue : Colors.grey,
      ),
    );
  }
}
