import 'package:cinemates/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;

class MyAlertDialogs {
  Widget cancelButton = TextButton(
    child: Text("Annulla"),
    onPressed: () {},
  );

  Widget continueButton = TextButton(
    child: Text("Continua"),
    onPressed: () {},
  );

  showDialogEmptyField(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Campo vuoto",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Text("I campi non possono essere vuoti!",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            actions: [
              TextButton(
                  child: Text("Capito!"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  showDialogInvalidField(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Campo invalido",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Text(
                "Uno dei campi risulta invalido.\n"
                "Assicurati di aver inserito il contenuto nel corretto formato:\n"
                "- lo username deve contenere almeno 6 caratteri;\n"
                "- assicurati che l'indirizzo e-mail non sia stato scritto in un formato non valido;\n"
                "- la password deve contenere almeno 8 caratteri;",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            actions: [
              TextButton(
                  child: Text("Capito!"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  showDialogSuccessfullRegistration(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Registrazione effettuata!",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Text(
                "Perfetto!\nLa registrazione è stata completata con successo.\n"
                "Ti diamo un caloroso benvenuto sulla nostra piattaforma!\n",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            actions: [
              TextButton(
                  child: Text("Inizia!"),
                  onPressed: () async {
                    await Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => HomeScreen()));
                  })
            ],
          );
        });
  }

  showDialogUsernameDuplicated(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Username già esistente",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Text(
                "Attenzione, la registrazione non è andata a buon fine poiché lo username utilizzato è già presente nei nostri database.\n"
                "Prova ad utilizzare uno username diverso!\n",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            actions: [
              TextButton(
                  child: Text("Capito!"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  showDialogEmailDuplicated(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("E-mail già esistente",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Text(
                "Attenzione, la registrazione non è andata a buon fine poiché la e-mail utilizzata è già presente nei nostri database.\n"
                    "Assicurati di non essere già registrato con questa mail.\n",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            actions: [
              TextButton(
                  child: Text("Capito!"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
}
