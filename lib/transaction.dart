/// 账单的实体类

class Transaction {
  final String uid;
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    required this.uid,
    required this.title,
    required this.amount,
    required this.date,
  });
}
