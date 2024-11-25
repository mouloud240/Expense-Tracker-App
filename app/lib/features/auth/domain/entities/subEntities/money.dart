class  Money {
  double amount;
  String currency;
  Money(this.amount,this.currency);
  @override
   String toString() {
    return "$amount $currency";   
  } 
}
