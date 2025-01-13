import 'package:design_patterns_strategy/payment_service.dart';
import 'package:design_patterns_strategy/strategies/card_payment_strategy.dart';
import 'package:design_patterns_strategy/strategies/one_time_card_payment_strategy.dart';
import 'package:design_patterns_strategy/strategies/pay_pal_payment_strategy.dart';
import 'package:design_patterns_strategy/strategies/payment_strategy.dart';
import 'package:design_patterns_strategy/text_widget.dart';
import 'package:flutter/material.dart';

class UiScreen extends StatefulWidget {
  const UiScreen({Key? key}) : super(key: key);

  @override
  State<UiScreen> createState() => _UiScreenState();
}

class _UiScreenState extends State<UiScreen> {
  TextEditingController textControllerEmail = TextEditingController();
  TextEditingController textControllerCard = TextEditingController();
  TextEditingController textControllerExpDate = TextEditingController();
  TextEditingController textControllerCvc = TextEditingController();
  TextEditingController textControllerMethodId = TextEditingController();
  TextEditingController textControllerAmount = TextEditingController();
  PaymentService paymentService = PaymentService();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextWidget(
                placeholder: 'input Amount',
                text: 'Amount',
                controller: textControllerAmount),
            SizedBox(
              height: 50,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PaypalPaymentStrategy'),
                    TextWidget(
                      placeholder: 'input email',
                      text: 'Card',
                      controller: textControllerEmail,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('OneTimeCardPaymentStrategy'),
                    TextWidget(
                        controller: textControllerCard,
                        placeholder: 'input Card instance',
                        text: 'OneTime'),
                    TextWidget(
                        placeholder: 'input expDate',
                        text: 'Card',
                        controller: textControllerExpDate),
                    TextWidget(
                      placeholder: 'input cvc',
                      text: 'Card',
                      controller: textControllerCvc,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CardPaymentStrategy'),
                    TextWidget(
                        placeholder: 'input Payment Method Id',
                        text: 'Card',
                        controller: textControllerMethodId),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () async {
                      if (textControllerEmail.text != '' &&
                          textControllerEmail.text != null) {
                        paymentService.setStrategy(
                            PaypalPaymentStrategy(textControllerEmail.text));
                      } else if (textControllerMethodId.text != '' &&
                          textControllerMethodId.text != null) {
                        paymentService.setStrategy(
                            CardPaymentStrategy(textControllerMethodId.text));
                      } else if (textControllerCard.text != '' &&
                          textControllerCard.text != null &&
                          textControllerExpDate.text != '' &&
                          textControllerExpDate.text != null &&
                          textControllerCvc.text != '' &&
                          textControllerCvc.text != null) {
                        paymentService.setStrategy(OneTimeCardPaymentStrategy(
                            textControllerCard.text,
                            textControllerExpDate.text,
                            textControllerCvc.text));
                      }

                      if (textControllerAmount.text != '' &&
                          textControllerAmount.text != null) {
                        final String messageToShow = await paymentService
                            .pay(double.parse(textControllerAmount.text));
                        print('messageToShow $messageToShow');
                        final snackBar = SnackBar(
                          content: Text(messageToShow),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text('Submit payment')))
          ],
        ),
      ),
    );
  }
}
