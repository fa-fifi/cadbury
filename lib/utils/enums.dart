enum Month {
  jan,
  feb,
  mar,
  apr,
  may,
  jun,
  jul;

  @override
  String toString() => name[0].toUpperCase() + name.substring(1);
}

enum Chocolate {
  flake,
  wispaGold,
  fudge,
  doubleDecker,
  twirl,
  crunchie,
  caramel,
  picnic,
  chomp;

  @override
  String toString() => name[0].toUpperCase() + name.substring(1);
}
