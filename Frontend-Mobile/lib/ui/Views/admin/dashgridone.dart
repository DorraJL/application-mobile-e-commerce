import 'package:e_commers/Models/Response/DashboardResponse.dart';
import 'package:e_commers/service/UserController.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:e_commers/ui/themes/constants.dart' as Constants;

class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}


class PieChart2State extends State {
  @override
  void initState() {
    super.initState();
  }

  late int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.3,
        child: FutureBuilder<DashboardModel>(
            future: userServices.dashboard(),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (!snapshot.hasData) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 18,
                      ),
                      // Container(
                      //   padding: EdgeInsets.only(left: 20.0),
                      //   alignment: Alignment.centerLeft,
                      //   height: 20.0,
                      //   child: Text(
                      //     'General Status',
                      //     style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),

                      //     ),
                      // ),
                      Container(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                                pieTouchData: PieTouchData(touchCallback:
                                    (FlTouchEvent event, pieTouchResponse) {
                                  setState(() {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection ==
                                            null) {
                                      touchedIndex = -1;
                                      return;
                                    }
                                    touchedIndex = pieTouchResponse
                                        .touchedSection!.touchedSectionIndex;
                                  });
                                }),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 60,
                                sections: List.generate(4, (i) {
                                  final isTouched = i == touchedIndex;
                                  final double fontSize = isTouched ? 25 : 16;
                                  final double radius = isTouched ? 100 : 80;

                                  switch (i) {
                                    case 0:
                                      return PieChartSectionData(
                                        color: Constants.card1,
                                        value: 45,
                                        title: snapshot.data!.totalProducts
                                            .toString(),
                                        radius: radius,
                                        titleStyle: TextStyle(
                                            fontSize: fontSize,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xffffffff)),
                                      );
                                    case 1:
                                      return PieChartSectionData(
                                        color: Constants.card2,
                                        value: 25,
                                        title: snapshot
                                                .data!.totalSoldProductAmount
                                                .toString() +
                                            ' TND',
                                        radius: radius,
                                        titleStyle: TextStyle(
                                            fontSize: fontSize,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xffffffff)),
                                      );
                                    case 2:
                                      return PieChartSectionData(
                                        color: Constants.card3,
                                        value: 15,
                                        title: snapshot.data!.totalSoldProduct
                                            .toString(),
                                        radius: radius,
                                        titleStyle: TextStyle(
                                            fontSize: fontSize,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xffffffff)),
                                      );
                                    case 3:
                                      return PieChartSectionData(
                                        color: Constants.card4,
                                        value: 15,
                                        title: snapshot.data!.totalClients
                                            .toString(),
                                        radius: radius,
                                        titleStyle: TextStyle(
                                            fontSize: fontSize,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xffffffff)),
                                      );
                                    default:
                                      return PieChartSectionData(
                                        color: Constants.card4,
                                        value: 15,
                                        title: snapshot.data!.totalClients
                                            .toString(),
                                        radius: radius,
                                        titleStyle: TextStyle(
                                            fontSize: fontSize,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xffffffff)),
                                      );
                                  }
                                })),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 18,
                            ),

                            //1
                            Row(
                              children: <Widget>[
                                Icon(Icons.devices,
                                    size: 30.0, color: Constants.card1),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                ),
                                Text(
                                  'Produits vendus',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15.0),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            //2
                            Row(
                              children: <Widget>[
                                Icon(Icons.cancel,
                                    size: 30.0, color: Constants.card3),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                ),
                                Text(
                                  'Produits hors Stock',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15.0),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            //3
                            Row(
                              children: <Widget>[
                                Icon(Icons.people,
                                    size: 30.0, color: Constants.card4),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                ),
                                Text(
                                  'Clients',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15.0),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            //4
                            Row(
                              children: <Widget>[
                                //Card1
                                Icon(Icons.attach_money_sharp,
                                    size: 30.0, color: Constants.card2),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                ),
                                Text(
                                  'Total Revenue',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15.0),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 4,
                            ),

                            SizedBox(
                              height: 18,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 28,
                      ),
                    ],
                  ),
                ],
              );
            }));
  }
}
