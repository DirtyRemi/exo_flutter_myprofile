class ProfileUtilisateur {
  // Caractéristiques
  String prenom;
  String nom;
  int age;
  bool genre;
  double taille;
  String motDePasse;
  List<String> listeHobbies;
  String favoriteLangageDev;

  // Constructeur
  ProfileUtilisateur({
    this.prenom = "",
    this.nom = "",
    this.age = 0,
    this.genre = true,
    this.taille = 0.0,
    this.motDePasse = "",
    this.listeHobbies = const [],
    this.favoriteLangageDev = "Dart"
  });

  // Méthodes
  String setName() => "$prenom $nom";
  String setAge() => "Age : $age" + (age > 1 ? " ans" : " an");
  String setGenre() => "Genre : " + ((genre) ? "Féminin" : "Masculin");
  String setTaille() => "Taille: ${taille.toInt()} cm";
  String setHobbies() {
    String toHobbiesString = "";
    if (listeHobbies.length == 0) {
      // return toHobbiesString;
      return "Hobbies : / ";
    } else {
      toHobbiesString = "Hobbies : ";
      listeHobbies.forEach((element) {
        toHobbiesString += "$element, ";
      });
      return toHobbiesString;
    }
  }
  String setFavoriteLangageDev() => "Langage Favori : $favoriteLangageDev";
}