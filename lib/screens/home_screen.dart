import 'package:budget_ui_205/data/data.dart';
import 'package:budget_ui_205/helpers/color_helper.dart';
import 'package:budget_ui_205/models/category_model.dart';
import 'package:budget_ui_205/models/expense_model.dart';
import 'package:budget_ui_205/widgets/bar_chart.dart';
import 'package:flutter/material.dart';

import 'category_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _buildCategory(Category category, double totalAmountSpent){
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CategoryScreen(category: category)
        )
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        padding: EdgeInsets.all(20.0),
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0,2),
              blurRadius: 6.0
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(category.name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600
                ),),
                Text('\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600
                ),)
              ],
            ),
            SizedBox(height: 10.0,),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints){
                final double maxBarWidth = constraints.maxWidth;
                final double percent = (category.maxAmount - totalAmountSpent) / category.maxAmount;
                double barWidth = percent * maxBarWidth;

                if(barWidth < 0){
                  barWidth = 0;
                }

                return Stack(
                  children: [
                    Container(
                      height: 20.0,
                      decoration: BoxDecoration(color: Colors.grey[200],borderRadius: BorderRadius.circular(15.0)),
                    ),
                    Container(
                      height: 20.0,
                      width: barWidth,
                      decoration: BoxDecoration(
                          color: getColor(context,percent),
                          borderRadius: BorderRadius.circular(15.0)
                      ),
                    )
                  ],
                );
              },

            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            //floating: true,
            pinned: true,
            expandedHeight: 100.0,
            leading: IconButton(
              icon: Icon(Icons.settings),
              iconSize: 30.0,
              onPressed: (){},
            ),
           flexibleSpace: FlexibleSpaceBar(
             title: Text('Simple Budget'),
           ),
            actions: [
              IconButton(
                  onPressed: (){},
                  iconSize: 30.0,
                  icon: Icon(Icons.add))
            ],
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index){
                    if(index == 0) {
                      return Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 2),
                                  blurRadius: 6.0
                              )
                            ],
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: BarCharts(expenses: weeklySpending),
                      );
                    }else {
                      final Category category = categories[index - 1];
                      double totalAmountSpent = 0;
                      category.expenses.forEach((Expense expense) {
                        totalAmountSpent += expense.cost;
                      });
                      return _buildCategory(category, totalAmountSpent);
                    }
                  },
                childCount: 1 + categories.length
              )
          )
        ],
      ),
    );
  }
}
