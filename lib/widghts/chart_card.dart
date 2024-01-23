import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import '/widghts/chart_bar.dart';

class ChartCard extends StatelessWidget {
  final List<Transaction> _recentTransations;

  const ChartCard(this._recentTransations, {super.key});

  List<({String day, double total})> get _groupList {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));

      double total = _recentTransations.fold(0, (previous, tx) {
        final date = tx.date;
        return date.year == weekday.year &&
                date.month == weekday.month &&
                date.day == weekday.day
            ? previous + tx.amount
            : previous;
      });

      return (day: DateFormat.E().format(weekday), total: total);
    }).toList();
  }

  double get totalAmount {
    return _recentTransations.fold(0.0, (previous, tx) => tx.amount + previous);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _groupList.map((summary) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                day: summary.day,
                total: summary.total,
                progress: totalAmount == 0 ? 0 : summary.total / totalAmount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
