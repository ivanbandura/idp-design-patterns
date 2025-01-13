import 'package:design_patterns_strategy/strategies/payment_strategy.dart';

class CardPaymentStrategy implements PaymentStrategy {
  CardPaymentStrategy(this.paymentMethodId);

  String paymentMethodId;

  @override
  Future<void> pay(double amount) async {
    if (paymentMethodId == 'validMethodId') {
    } else {
      throw Exception('CardPaymentStrategy exception');
    }
  }
}
