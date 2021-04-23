 abstract class Payment {
  
  double amount;


   double getAmount() {
    return amount;
  }
   void setAmount(double amount) {
    this.amount= amount;
  }

   bool process();

}