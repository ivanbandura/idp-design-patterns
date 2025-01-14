class Superhero {
  String name;
  String superpower;

  Superhero(String name, String superpower) {
    this.name = name;
    this.superpower = superpower;
  }

  void useSuperpower() {
    print('$name is using their superpower: $superpower');
  }
}

class NewSuperhero extends Superhero {
  String costumeColor;

  NewSuperhero(String name, String superpower, this.costumeColor) : super(name, superpower);
}

void main() {
  Superhero originalHero = Superhero('Superman', 'Flight');

  originalHero.useSuperpower();

  NewSuperhero newHero = NewSuperhero('Wonder Woman', 'Lasso of Truth', 'Red');

  newHero.useSuperpower();
}
