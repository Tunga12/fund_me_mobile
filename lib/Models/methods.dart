
class Counter {
  static String getCounter(int number) {
    print("counter $number");

    String counterValue = '';
    if (number < 1000) {
      counterValue = '$number';
    } else if (number >= 1000 && number < 1000000) {
      double value = number / 1000;
      if (number % 1000 == 0) {
        counterValue = '${value.toInt()}K';
      } else {
        String strValue = value.toStringAsFixed(1);
        counterValue = "$strValue" + 'K';
      }
    } else if (number >= 1000000 && number < 1000000000) {
      double value = number / 1000000;
      if (number % 1000000 == 0) {
        counterValue = '${value.toInt()}M';
      } else {
        String strValue = value.toStringAsFixed(1);
        counterValue = '$strValue' + 'M';
      }
    }
    return counterValue;
  }
}
