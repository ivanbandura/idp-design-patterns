import 'package:design_patterns_strategy/strategies/payment_strategy.dart';

class PaypalPaymentStrategy implements PaymentStrategy{
  PaypalPaymentStrategy (this.email);
  String email;
  @override
  Future<void> pay(double amount) async {
    if(email == 'valid@email.com'){

        } else {
      throw Exception('PaypalPaymentStrategy exception');
    }

}
}