class  Money {
  double amount;
  String currency;
  Map <String,String>currencies={
    "USD":"\$",
    "EUR":"€",
    "GBP":"£",
    "JPY":"¥",
    "CNY":"¥",
    "INR":"₹",
    "RUB":"₽",
    "AUD":"A\$",
    "CAD":"C\$",
    "SGD":"S\$",
    "CHF":"Fr",
    "MYR":"RM",
    "ZAR":"R",
    "SEK":"kr",
    "NOK":"kr",
    "DKK":"kr",
    "CZK":"Kč",
    "HUF":"Ft",
    "PLN":"zł",
    "TRY":"₺",
    "BRL":"R\$",
    "IDR":"Rp",
    "KRW":"₩",
    "MXN":"\$",
    "PHP":"₱",
    "THB":"฿",
    "VND":"₫",
    "CLP":"\$",
    "ILS":"₪",
    "ARS":"\$",
    "COP":"\$",
    "AED":"د.إ",
    "HKD":"HK\$",
    "EGP":"E£",
  "DZD":"DA",};
  Money(this.amount,this.currency);
  @override
   String toString() {
    return "$amount $currency";   
  }
  String toSymbol(){
    String symbol= currencies[currency]??currency;
    return "$symbol${amount.toInt()} ";
  }
}
