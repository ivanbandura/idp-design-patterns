import 'package:design_patterns_strategy/strategies/card_payment_strategy.dart';
import 'package:design_patterns_strategy/strategies/one_time_card_payment_strategy.dart';
import 'package:design_patterns_strategy/strategies/pay_pal_payment_strategy.dart';
import 'package:design_patterns_strategy/strategies/payment_strategy.dart';

class PaymentService {
  late PaymentStrategy paymentStrategy;

  setStrategy(PaymentStrategy paymentStrategy) {
    this.paymentStrategy = paymentStrategy;
    print('paymentStrategy ${paymentStrategy}');
  }

  Future<String> pay(double amount) async {
    try {
      print('pay1 $amount');

     await paymentStrategy.pay(amount);
      print('');
      print('pay2 $amount');

      if(paymentStrategy is PaypalPaymentStrategy ) {
        return 'success payed PaypalPaymentStrategy';
      } else   if(paymentStrategy is OneTimeCardPaymentStrategy ) {
        return 'success payed OneTimeCardPaymentStrategy';
      } else   if(paymentStrategy is CardPaymentStrategy ) {
        return 'success payed CardPaymentStrategy';
      } else {
        return 'ERROR';
      }
    } catch (_) {
      return 'error $_';
    }
  }
}
