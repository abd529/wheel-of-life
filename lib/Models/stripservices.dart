// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stripe_checkout/stripe_checkout.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StripeService {
  static String? secretKey = dotenv.env['STRIPE_SECRET'];
  static String? publishKey = dotenv.env['STRIPE_PUB'];

  static Future<dynamic> createCheckoutSession(
      List<dynamic> productItems, totalAmount) async {
    final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");
    String lineItems = "";
    int index = 0;

    // ignore: avoid_function_literals_in_foreach_calls
    productItems.forEach((val) {
      var productPrice = (val["productPrice"] * 100).round().toString();
      lineItems +=
          "&line_items[$index][price_data][product_data][name]=${val["productName"]}&line_items[$index][price_data][unit_amount]=$productPrice";
      lineItems += "&line_items[$index][price_data][currency]=USD";
      lineItems += "&line_items[$index][quantity]=${val["qty"].toString()}";
      index++;
    });

    final response = await http.post(url,
        body:
            "success_url=https://checkout.stripe.dev/success&mode=payment$lineItems",
        headers: {
          "Authorization": "Bearer $secretKey",
          "Content-Type": "application/x-www-form-urlencoded"
        });
    print("stripe ressssponse:");
    print(response.body);
    return json.decode(response.body)["id"];
  }

  static Future<dynamic> stripePaymentCheckout(
      productItems, subTotal, context, mounted,
      {onSuccess, onError, onCancel}) async {
    final String sessionId =
        await createCheckoutSession(productItems, subTotal);
    print("token: $sessionId");
    final result = await redirectToCheckout(
        context: context,
        sessionId: sessionId,
        publishableKey: publishKey.toString(),
        successUrl: "https://checkout.stripe.dev/success",
        canceledUrl: "https://checkout.stripe.dev/cancel");
    if (mounted) {
      final text = result.when(
        redirected: () => "Redirected Succesfully",
        success: () => onSuccess(sessionId),
        canceled: () => onCancel(),
        error: (e) => onError(e),
      );
      return text;
    }
    return sessionId;
  }
}
