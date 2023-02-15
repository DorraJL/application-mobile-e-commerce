import 'package:e_commers/ui/Views/admin/dashgridone.dart';
import 'package:e_commers/ui/Views/admin/dashgridtwo.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget{

  final TabController tabController;

  Dashboard(this.tabController);

  @override
  State<StatefulWidget> createState() {
    return DashboardState(tabController);
  }
}
class DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin{
  
  TabController tabController;
 
  DashboardState(this.tabController);


  @override
  Widget build(BuildContext context) {
    
    var app = TabBarView(
      controller: tabController,
      children: <Widget>[
        // Gridone(),
       PieChartSample2(),
       Gridtwo(controller: tabController),
       
      ],
      
    );

    return app;
  }

}  


    