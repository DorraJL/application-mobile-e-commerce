import 'package:e_commers/Models/Response/DashboardResponse.dart';
import 'package:e_commers/Service/UserController.dart';

import 'package:flutter/material.dart';
import 'package:e_commers/ui/themes/constants.dart' as Constants;

class Gridtwo extends StatelessWidget {
  final TabController controller;
  Gridtwo({required this.controller});
 

  final Color textColor = Constants.textColor;
  final Color card1 = Constants.card1;
  final Color card2 = Constants.card2;
  final Color card3 = Constants.card3;
  final Color card4 = Constants.card4;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DashboardModel>(
        future: userServices.dashboard(),
        builder: (context, snapshot) {
          print(snapshot.data);
          print(snapshot.data?.totalClients);
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              //Card 1

              Card(
                  color: Constants.card1,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 5.0, top: 20.0, bottom: 20.0),
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Align(
                    alignment: Alignment.center,
                  
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Icon(Icons.add_shopping_cart,
                                size: 30.0, color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Produits vendus: ' +
                                snapshot.data!.totalProducts.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )),
              // Card 2
              Card(
                color: Constants.card2,
                margin: EdgeInsets.only(
                    left: 5.0, right: 10.0, top: 20.0, bottom: 20.0),
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Align(
                    alignment: Alignment.center,
                  
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            flex: 8,
                            child: Padding(
                              padding: EdgeInsets.only(top: 30.0),
                              child: Icon(Icons.monetization_on_rounded,
                                  size: 30.0, color: Colors.white),
                            )),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Total Revenue: ' +
                                snapshot.data!.totalSoldProductAmount
                                    .toString() +
                                ' TND',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )),
              ),
              //Card 3
              Card(
                //margin: EdgeInsets.only(left: 40.0, top: 40.0, right: 40.0, bottom: 20.0),
                color: Constants.card4,
                margin: EdgeInsets.only(
                    left: 10.0, right: 5.0, top: 10.0, bottom: 20.0),
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Align(
                    alignment: Alignment.center,
                 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 8,
                          child: Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Icon(Icons.people,
                                size: 30.0, color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Clients: ' +
                                snapshot.data!.totalClients.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )),
              ),
              //Card 4
              Card(
                //   margin: EdgeInsets.only(left: 40.0, top: 40.0, right: 40.0, bottom: 10.0),
                margin: EdgeInsets.only(
                    left: 5.0, right: 10.0, top: 10.0, bottom: 20.0),
                color: card3,
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: Align(
                    alignment: Alignment.center,
                  
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Icon(Icons.cancel,
                                  size: 30.0, color: Colors.white),
                            )),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Produits Hors Stock: ' +
                                snapshot.data!.totalSoldProduct.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          );
        });
  }

}
