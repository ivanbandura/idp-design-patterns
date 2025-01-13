import 'package:design_patterns_strategy/strategies/payment_strategy.dart';

class OneTimeCardPaymentStrategy implements PaymentStrategy {
  OneTimeCardPaymentStrategy(this.cardNumber, this.expDate, this.cvc);

  String cardNumber;
  String expDate;
  String cvc;

  @override
  Future<void> pay(double amount) async {
    if(cardNumber.contains('1234') && expDate.contains('1') && cvc.contains('1') ){

    }
    else {
      throw Exception('OneTimeCardPaymentStrategy Exception');
    }
  }
}
