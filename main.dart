import 'package:exo_profile_flutter/profile.dart';
import 'package:flutter/material.dart';
import 'profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Mon Profil'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ProfileUtilisateur myProfile = new ProfileUtilisateur(
    prenom: "Rémi",
    nom: "CODABEE",
    age: 30,
    genre: false,
    taille: 100,
    //motDePasse: "azerty",
    //favoriteLangageDev: "Dart",
    //listeHobbies: ["Karaté", "Informatique", "Pétanque", "Musculation", "Musique", "Mojitos"]
  );

  late TextEditingController prenom;
  late TextEditingController nom;
  late TextEditingController motDePasse;

  bool isSecret = true;

  Map<String, bool> mapHobbies = {
    "Pétanque": false,
    "Football": false,
    "Rugby": false,
    "Code": false,
    "Karaté": false
  };

  Map<int, String> mapLangages = {
    1: "Dart",
    2: "Fortran",
    3: "SQL",
    4: "CSharp",
    5: "Java",
    6: "Swift",
    7: "C"
  };
  int groupValueLangagesDev = 0;

 @override
 void initState() {
   super.initState();
   nom = TextEditingController();
   prenom = TextEditingController();
   motDePasse = TextEditingController();
 }

 @override
 void dispose () {
   nom.dispose();
   prenom.dispose();
   motDePasse.dispose();
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size; // Récupére la taille
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
                  children: [
                    myProfileBloc(screenWidth),
                    myDivider(),
                    myTitle("Modifier les infos"),
                    myTextField(champ: "prenom", valeurTextCapitalization: 0, controller: prenom, hint: "Entrez votre prénom"),
                    myTextField(champ: "nom", valeurTextCapitalization: 2, controller: nom, hint: "Entrez votre nom"),
                    myTextField(champ: "motdepasse", valeurTextCapitalization: 3, controller: motDePasse, hint: "Entrez votre mot de passe", isSecret: isSecret),
                    myGender(),
                    mySize(),
                    myDivider(),
                    myTitle("Mes Hobbies"),
                    myHobbies(),
                    myDivider(),
                    myTitle("Langage de dev préféré"),
                    SingleChildScrollView(
                      child: myLangages(),
                      scrollDirection: Axis.horizontal,
                    )
                  ],
                )
            )
        )
    );
  }

  Container myProfileBloc (screenWidth) {
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        width: screenWidth.width,
        decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(5)
        ),
        //elevation: 10,
        child: Column(
          //mainAxisSize: MainAxisSize.max,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(myProfile.setName()),
            Text(myProfile.setAge()),
            Text(myProfile.setTaille()),
            Text(myProfile.setGenre()),
            Text(myProfile.setHobbies()),
            Text(myProfile.setFavoriteLangageDev()),
            ElevatedButton(
                onPressed: (() {
                  setState(() {
                    isSecret = !isSecret;
                  });
                }),
                child:
                Text((isSecret) ? "Montrer le secret" : "Cacher le secret")
            )
          ],
        )
    );
  }

  Widget myTextField({
    required String champ,  // type de champs : prenom, nom, mot de passe.
    required int valeurTextCapitalization,
    required TextEditingController controller,
    required String hint,
    bool isSecret = false,
  }) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(hintText: hint),
        obscureText: isSecret,
        textCapitalization: TextCapitalization.values[valeurTextCapitalization],
        onChanged: ((newValue) {
          setState(() {
            if (champ == "prenom") {
              myProfile.prenom = newValue;
            } else if (champ == "nom") {
              myProfile.nom = newValue;
            } else if (champ == "motdepasse") {
              myProfile.motDePasse = newValue;
            }
          });
        }));
  }

  Divider myDivider() {
    return Divider(color: Colors.indigoAccent, thickness: 2, indent: 10, endIndent: 10);
  }

  Text myTitle(titre) {
    return Text(titre,
        style: TextStyle(color: Colors.indigoAccent,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ));
  }

  Column myHobbies () {
    List<Widget> listWidHobbies = [];       // Tous les hobbies de la map
    List<String> listHobbiesChecked = [];   // Uniquement les hobbies cochés
    mapHobbies.forEach((key, value) {
      Widget rowHobbies = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(key),
          Checkbox(value: value,
              onChanged: ((newValue) {
                setState(() {
                  //List<String> listHobbiesChecked = [];  //
                  mapHobbies[key] = newValue ?? false;
                  mapHobbies.forEach((key, value) {
                    if (value) {
                      listHobbiesChecked.add(key);
                    }
                  }
                  );
                  myProfile.listeHobbies = listHobbiesChecked;
                });
              })
          )
        ],
      );
      listWidHobbies.add(rowHobbies);
    }
    );
    return Column(children: listWidHobbies);
  }

  Widget myGender(){
    return Row (
      //mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Genre : " + ((myProfile.genre) ? "Féminin" : "Masculin")),
          //Spacer(), remplacé par mainAxisAlignement
          Switch(value: myProfile.genre,
            onChanged: ((newValue) {
              setState(() => myProfile.genre = newValue);
            }),
            activeColor: Colors.pink,
            activeTrackColor: Colors.black26,
            inactiveTrackColor: Colors.black26,
            inactiveThumbColor: Colors.indigoAccent,
          ),
        ]
    );
  }

  Widget mySize() {
    return Row(children: [
      Text("Taille : " + myProfile.taille.toInt().toString() + " cm"),
      Spacer(),
      Slider(
          min: 1,
          max: 250,
          value: myProfile.taille,
          onChanged: ((newValue) {
            setState(() {
              myProfile.taille = newValue;
            });
          })),
    ]);
  }

  Row myLangages() {
    List<Widget> listWidgets = [];
    mapLangages.forEach((numero, langage) {
      Row r = Row(
        children: [
          Text(langage + " : "),
          Radio(
            value: numero,
            groupValue: groupValueLangagesDev,
            onChanged: ((newValue) {
              setState(() {
                groupValueLangagesDev = newValue as int;
                print("Numéro: $numero, newValue: $newValue, langage: $langage");
                myProfile.favoriteLangageDev = langage;
              }); // setState
            }),   // onChanged
          )
        ],        // children
      );
      listWidgets.add(r);
    });
    return Row(children: listWidgets);
  }


}
