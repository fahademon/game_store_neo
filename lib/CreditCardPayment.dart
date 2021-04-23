import 'Payment.dart';

class CreditCardPayment extends Payment{

  static CreditCardPayment _instance = CreditCardPayment._CreditCardPayment();

  String cvv, expirationDate, creditCardNumber;

  CreditCardPayment._CreditCardPayment();

  factory CreditCardPayment()
  {
    return _instance;
  }



  void setDetails(String cardNumber, String expiration, String cvv, double amount) {
    this.creditCardNumber = cardNumber;
    this.expirationDate = expiration;
    this.cvv = cvv;
    this.amount = amount;
  }

  @override
  bool process() {
    return true;
  }
}
