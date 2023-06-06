import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StripeBalanceScreen extends StatefulWidget {
  @override
  _StripeBalanceScreenState createState() => _StripeBalanceScreenState();
}

class _StripeBalanceScreenState extends State<StripeBalanceScreen> {
  String _balance = '';

  @override
  void initState() {
    super.initState();
    fetchBalance();
  }

  Future<void> fetchBalance() async {
    final apiKey = 'https://api.stripe.com/v1/payment_intents';
    final url = 'https://api.stripe.com/v1/balance';
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $apiKey'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final available = jsonResponse['available'][0]['amount'];
      final currency = jsonResponse['available'][0]['currency'];

      setState(() {
        _balance = '$available $currency';
      });
    } else {
      setState(() {
        _balance = 'Error fetching balance';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stripe Balance'),
      ),
      body: Center(
        child: Text(
          'Balance: $_balance',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
