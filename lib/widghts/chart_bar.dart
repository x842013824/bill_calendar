import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double total;
  final double progress;

  const ChartBar({
    super.key,
    required this.day,
    required this.total,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '\$${total.toStringAsFixed(0)}',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          width: 10,
          height: 60,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              FractionallySizedBox(
                heightFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          day,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        )
      ],
    );
  }
}
