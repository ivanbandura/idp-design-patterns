class ChocolateChipCookie {
  String flavor;
  int numberOfChips;
  bool isSoft;

  ChocolateChipCookie(String flavor, int numberOfChips, bool isSoft) {
    this.flavor = flavor;
    this.numberOfChips = numberOfChips;
    this.isSoft = isSoft;
  }

  void describeCookie() {
    print('A delicious $flavor chocolate chip cookie with $numberOfChips chocolate chips.');
    if (isSoft) {
      print('This cookie is soft and chewy!');
    } else {
      print('This cookie has a nice crunch!');
    }
  }
}

void main() {
  ChocolateChipCookie firstBatch = ChocolateChipCookie('Classic', 50, true);
  ChocolateChipCookie secondBatch = ChocolateChipCookie('Double Chocolate', 75, false);

  print('First Batch:');
  firstBatch.describeCookie();
  print('\nSecond Batch:');
  secondBatch.describeCookie();
}
