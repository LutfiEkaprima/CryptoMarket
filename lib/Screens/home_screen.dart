import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projectuts/Screens/CoinChartScreen.dart';
import 'package:projectuts/controllers/coin_controllers.dart';
import 'package:projectuts/utils.dart';

class HomeScreen extends StatelessWidget {
  final CoinController controller = Get.put(CoinController());

  static const IconData arrow_drop_up_rounded =
      IconData(0xf578, fontFamily: 'MaterialIcons');
  static const IconData arrow_drop_down_rounded =
      IconData(0xf577, fontFamily: 'MaterialIcons');

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final padding = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 231, 234),
      body: Padding(
        padding: EdgeInsets.only(
            left: padding, right: padding, top: screenHeight * 0.02),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                "Crypto Watcher",
                style: textStyle(screenWidth * 0.040, Colors.black, FontWeight.w400),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            Obx(
              () => controller.isLoading.value
                  ? const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final coin = controller.coinsList[index];
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => CoinChartScreen(coin: coin),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: SizedBox(
                                width: screenWidth,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Image.network(coin.image),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              coin.name,
                                              style: textStyle(
                                                  screenWidth * 0.04,
                                                  Colors.black,
                                                  FontWeight.w600),
                                            ),
                                            Row(
                                              children: [
                                                if (coin.priceChange24H > 0)
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        arrow_drop_up_rounded,
                                                        color: Colors.green,
                                                        size:
                                                            screenWidth * 0.05,
                                                      ),
                                                      Text(
                                                        "${coin.priceChange24H.toStringAsFixed(2)} %",
                                                        style: textStyle(
                                                          screenWidth * 0.035,
                                                          Colors.green,
                                                          FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                if (coin.priceChange24H < 0)
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        arrow_drop_down_rounded,
                                                        color: Colors.red,
                                                        size:
                                                            screenWidth * 0.05,
                                                      ),
                                                      Text(
                                                        "${coin.priceChange24H.toStringAsFixed(2)} %",
                                                        style: textStyle(
                                                          screenWidth * 0.035,
                                                          Colors.red,
                                                          FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "\$ ${coin.currentPrice}",
                                            style: textStyle(
                                                screenWidth * 0.04,
                                                Colors.black,
                                                FontWeight.w600),
                                          ),
                                          Text(
                                            coin.symbol,
                                            style: textStyle(
                                                screenWidth * 0.035,
                                                Colors.grey,
                                                FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: controller.coinsList.length,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
