class Vehicle {
  void start() {
    print('Vehicle is starting...');
  }
}

class Car extends Vehicle {
  @override
  void start() {
    print('Car engine is roaring to life!');
  }
}

class Bike extends Vehicle {
  @override
  void start() {
    print('Bike engine is revving up!');
  }
}

class Truck extends Vehicle {
  @override
  void start() {
    print('Truck engine is rumbling!');
  }
}

void main() {
  Vehicle genericVehicle = Vehicle();
  Car myCar = Car();
  Bike myBike = Bike();
  Truck myTruck = Truck();

  genericVehicle.start();
  myCar.start();
  myBike.start();
  myTruck.start();
}
