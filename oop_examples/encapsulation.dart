class Doll {
  String _hiddenGift;

  Doll(String hiddenGift) {
    this._hiddenGift = hiddenGift;
  }

  /**
   * Method to reveal the hidden gift
   * This method encapsulates the process of revealing the surprise inside the doll.
   * It ensures that the hidden gift is only accessed through this controlled method.
   */
  String revealHiddenGift() {
    return _hiddenGift;
  }
}

void main() {
  Doll specialDoll = Doll('A tiny magical key');

  String revealedGift = specialDoll.revealHiddenGift();

  print('Revealed Gift: $revealedGift');
}
