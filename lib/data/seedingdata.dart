import 'package:snack_swap/models/country.dart';
import 'package:snack_swap/models/snack.dart';
import 'package:snack_swap/models/user.dart';

final List<Country> countries = [
  Country(
    name: "The Netherlands",
    flagImageUrl: "assets/vlags/vlag_netherlands.png",
  ),
  Country(
    name: "Germany",
    flagImageUrl: "assets/vlags/vlag_duitsland.png",
  ),
  Country(
    name: "Japan",
    flagImageUrl: "assets/vlags/vlag_japan.png",
  ),
];

final List<User> seedingUsers = [
  User(
    userID: "1",
    name: "Niek",
    password: "wachtwoord",
    country: "The Netherlands",
    countryImgUrl: "assets/vlags/vlag_netherlands.png",
  ),
  User(
    userID: "2",
    name: "Willem",
    password: "wachtwoord123",
    country: "Germany",
    countryImgUrl: "assets/vlags/vlag_duitsland.png",
  ),
  User(
    userID: "3",
    name: "Yuki Tsunoda",
    password: "Vis",
    country: "Japan",
    countryImgUrl: "assets/vlags/vlag_japan.png"
  ),
];

final List<Snack> snacks = [
  Snack(
    name: "Stroopwafel",
    description: "A waffle made from two thin layers of baked dough with a caramel-like syrup filling in the middle.",
    country: "The Netherlands",
    userID: "1",
    countryImgUrl: "assets/vlags/vlag_netherlands.png",
    imageImgUrl: "assets/snacks/stroopwafel.png",
    haveTraded: ["1", "2"]
  ),
  Snack(
    name: "pretzel",
    description: "A type of baked pastry made from dough that is commonly shaped into a knot.",
    country: "Germany",
    userID: "2",
    countryImgUrl: "assets/vlags/vlag_duitsland.png",
    imageImgUrl: "assets/snacks/pretzel.png",
  ),
  Snack(
    name: "pretzel",
    description: "A type of baked pastry made from dough that is commonly shaped into a knot.",
    country: "Germany",
    userID: "2",
    countryImgUrl: "assets/vlags/vlag_duitsland.png",
    imageImgUrl: "assets/snacks/pretzel.png",
  ),
  Snack(
    name: "pretzel",
    description: "A type of baked pastry made from dough that is commonly shaped into a knot.",
    country: "Germany",
    userID: "2",
    countryImgUrl: "assets/vlags/vlag_duitsland.png",
    imageImgUrl: "assets/snacks/pretzel.png",
    haveTraded: ["2"]
  ),
  Snack(
    name: "Pocky",
    description: "Chocolate-coated biscuit sticks, a popular Japanese snack food.",
    country: "Japan",
    userID: "3",
    countryImgUrl: "assets/vlags/vlag_japan.png",
    imageImgUrl: "assets/snacks/pocky.png",
  ),
  Snack(
    name: "Drop",
    description: "Dutch licorice that comes in many varieties, both sweet and salty.",
    country: "The Netherlands",
    userID: "1",
    countryImgUrl: "assets/vlags/vlag_netherlands.png",
    imageImgUrl: "assets/snacks/drop.png",
  ),
  Snack(
    name: "Drop",
    description: "Dutch licorice that comes in many varieties, both sweet and salty.",
    country: "The Netherlands",
    userID: "1",
    countryImgUrl: "assets/vlags/vlag_netherlands.png",
    imageImgUrl: "assets/snacks/drop.png",
  ),
  Snack(
    name: "Haribo",
    description: "Famous German gummy bears and other fruit gum candies.",
    country: "Germany",
    userID: "2",
    countryImgUrl: "assets/vlags/vlag_duitsland.png",
    imageImgUrl: "assets/snacks/haribo.png",
  ),
];