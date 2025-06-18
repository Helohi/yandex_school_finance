import 'package:flutter/material.dart';
import 'package:yandex_school_finance/presentation/pages/todays_transaction_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.isIncome});

  final bool isIncome;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Moя история"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.pending_actions)),
        ],
      ),
      body: Column(
        children: [
          TopListTile(title: "Начало", trailing: "Февраль 27, 2025"),
          TopListTile(title: "Конец", trailing: "Февраль 27, 2025"),
          TopListTile(title: "Сумма", trailing: "125 868 ₽"),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => ListTile(title: Text("$index")),
            ),
          ),
        ],
      ),
    );
  }
}
