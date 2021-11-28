import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarCharts extends StatelessWidget {


  final List<double> expenses;
  BarCharts({required this.expenses});

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    expenses.forEach((double price) {
      if(price > mostExpensive){
        mostExpensive = price;
      }
    });

    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text('Weekly Spending',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),),
          SizedBox(height: 5.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: (){}, icon: Icon(Icons.arrow_back),iconSize: 30.0,),
              Text('Nov 10,2019 - Nov16,2019',
              style: TextStyle(
                letterSpacing: 1.2,
                fontSize: 18.0,
                fontWeight: FontWeight.w600
              ),),
              IconButton(
                onPressed: (){},
                icon: Icon(Icons.arrow_forward),
                iconSize: 30.0,
              )
            ],
          ),
          SizedBox(height: 30.0,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Bar(label: 'Su',amountSpent: expenses[0],mostExpensive: mostExpensive,),
              Bar(label: 'Mo',amountSpent: expenses[1],mostExpensive: mostExpensive,),
              Bar(label: 'Tu',amountSpent: expenses[2],mostExpensive: mostExpensive,),
              Bar(label: 'We',amountSpent: expenses[3],mostExpensive: mostExpensive,),
              Bar(label: 'Thu',amountSpent: expenses[4],mostExpensive: mostExpensive,),
              Bar(label: 'Fri',amountSpent: expenses[5],mostExpensive: mostExpensive,),
              Bar(label: 'St',amountSpent: expenses[6],mostExpensive: mostExpensive,)
            ],
          )
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;

  final double _maxBarHeight = 150.0;

  Bar({required this.label,required this.amountSpent, required this.mostExpensive});

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;

    return Column(

      children: [
        Text('\$${amountSpent.toStringAsFixed(2)}',
        style: TextStyle(
          fontWeight: FontWeight.w600
        ),),
        SizedBox(height: 6.0,),
        Container(
          height: barHeight,
          width: 18.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(6.0)),
        ),
        SizedBox(height: 6.0,),
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600
          ),
        )
      ],
    );
  }
}
