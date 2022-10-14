import 'package:b201_app/presentation/widgets/payment_status_widget.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: const [
            PaymentStatusWidget(
              isPaid: true,
              date: '28 September',
            ),
          ],
        ),
      ),
    );
  }
}
