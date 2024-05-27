import 'package:get/get.dart';
import 'package:projectuts/models/coin_model.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';

class CoinController extends GetxController {
  RxBool isLoading = true.obs;
  RxList<Coin> coinsList = <Coin>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCoins();
  }

  fetchCoins() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd'),
      );

      if (response.statusCode == 429) {
        throw Exception("Rate Limit API, Max 30 Request Permenitnya");
      }

      List<Coin> coins = coinFromJson(response.body);
      coinsList.value = coins;
    } finally {
      isLoading(false);
    }
  }

  Future<List<FlSpot>> fetchCoinHistory(String coinId, int days) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.coingecko.com/api/v3/coins/$coinId/market_chart?vs_currency=usd&days=$days'),
      );

      if (response.statusCode == 429) {
        throw Exception("Rate Limit API, Max 30 Request Permenitnya");
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['prices'] as List;
        return data.asMap().entries.map((entry) {
          return FlSpot(entry.key.toDouble(), entry.value[1]);
        }).toList();
      } else {
        throw Exception('Failed to load coin history');
      }
    } catch (e) {
      rethrow;
    }
  }
}
