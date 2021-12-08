import 'package:cinemates/database_model/user.dart';
import 'package:cinemates/model/custom_list.dart';
import 'package:cinemates/screens/home_screen.dart';
import 'package:cinemates/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:cinemates/style/theme.dart' as Style;
import 'package:flutter_session/flutter_session.dart';

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
                "- assicurati che l'indirizzo e-mail sia stato scritto in un formato valido;\n"
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

  showDialogInvalidLoginField(BuildContext context) {
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
                "- assicurati che l'indirizzo e-mail sia stato scritto in un formato valido;\n",
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

  showDialogSuccessfullLogin(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Login effettuato!",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Text(
                "Bentornato sulla nostra piattaforma!\n"
                "Ci sei mancato! Inizia subito a navigare tra migliaia di titoli e TV Series.\n"
                "Puoi marcare i titoli come preferiti o fare una lista personalizzata, aggiungere amici e altro. Divertiti!",
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
                            builder: (BuildContext context) => LoginScreen()));
                  })
            ],
          );
        });
  }

  showDialogFailedLogin(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Errore in fase di login.",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Text(
                "I dati inseriti non risultano nei nostri database.\n"
                "Assicurati di esserti già registrato, dunque torna qui e prova a inserire email e password che hai inserito in fase di registrazione.\n"
                "Se sei già registrato, riprova a inserire la password o la e-mail correttamente.",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            actions: [
              TextButton(
                  child: Text("Indietro"),
                  onPressed: () {
                    Navigator.pop(context);
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

  showDialogDuplicatedFavoriteMovie(BuildContext context) {
    SnackBar snackBar =
        SnackBar(content: Text('Titolo rimosso dai tuoi preferiti!'));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Film già presente nei preferiti",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Text(
                "Il titolo ci risulta già presente nella tua lista dei preferiti! Non c'è bisogno di aggiungerlo due volte!\n\n"
                "Vuoi rimuoverlo dai preferiti?",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            actions: [
              TextButton(
                  child: Text("Annulla"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text("Rimuovi dai preferiti"),
                  onPressed: () async {
                    int _userId = await FlutterSession().get('token');
                    int _movieId = await FlutterSession().get('movieId');
                    User().removeMovieFavorite(_movieId, _userId);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  })
            ],
          );
        });
  }

  showDialogMovieAddedToFavorites(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Titolo aggiunto ai tuoi preferiti!",
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

  showDialogLoginFirst(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Login non effettuato",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Text(
                "Attenzione, per l'operazione scelta è necessario effettuare il login per l'identificazione utente.\n"
                "Apri il menù a tendina a sinistra, e dirigiti alla pagina di login per aggiungere film ai preferiti!",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            actions: [
              TextButton(
                  child: Text("Login ora!"),
                  onPressed: () async {
                    await Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()));
                  }),
              TextButton(
                  child: Text("Capito!"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  showDialogRemovedFromList(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Rimozione titolo",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Text("Il titolo è stato rimosso con successo dalla lista.",
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

  showDialogCreateCustomListForm(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();
    SnackBar snackBar = SnackBar(content: Text('La lista è stata creata!'));

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Crea lista",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _titleController,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    cursorColor: Style.Colors.secondColor,
                    cursorWidth: 1.5,
                    decoration: InputDecoration(
                      hintText: "Titolo...",
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Style.Colors.secondColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: _descriptionController,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    cursorColor: Style.Colors.secondColor,
                    cursorWidth: 1.5,
                    decoration: InputDecoration(
                      hintText: "Breve descrizione...",
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 14.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Style.Colors.secondColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  child: Text("Annulla"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text("Crea la lista!"),
                  onPressed: () async {
                    int _idUser = await FlutterSession().get('token');
                    User().createCustomList(_idUser,
                        _descriptionController.text, _titleController.text);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  })
            ],
          );
        });
  }

  showDialogAddMovieInCustomList(BuildContext context, int movieId,
      String title, String poster, List<String> titles) async {
    SnackBar snackBar = SnackBar(content: Text('Film aggiunto alla lista!'));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Seleziona lista in cui aggiungere il titolo",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 25.0,
                    );
                  },
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: titles.length,
                  itemBuilder: (context, index) {
                    if (titles.length == 0) {
                      return Text(
                          "Non hai ancora creato delle liste personalizzate");
                    } else {
                      return GestureDetector(
                        child: Text(titles[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                height: 1.5)),
                        onTap: () {
                          User().addMovieToCustomList(
                              movieId, title, poster, titles[index]);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      );
                    }
                  }),
            ),
            actions: [
              TextButton(
                  child: Text("Annulla"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  showDialogFriendRequestSent(BuildContext context, String username) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Richiesta amicizia",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Text(
                "La richiesta di amicizia è stata inviata con successo all'utente @$username",
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

  showDialogFriendRequestError(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Richiesta amicizia",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Text(
                "Il nome utente inserito sembra non esistere. Assicurati di aver scritto lo username corretto!",
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

  showDialogFriendRequestAlreadyExists(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Richiesta amicizia",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Text(
                "L'utente inserito è già presente nella lista amici, oppure hai già inviato una richiesta di collegamento.",
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

  showDialogFriendRequestAccepted(BuildContext context, String username) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Richiesta amicizia",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Text(
                "Richiesta di amicizia accettata! Ora l'utente @$username è tuo amico!",
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

  showDialogFriendRequestRejected(BuildContext context, String username) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Richiesta amicizia",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Text(
                "Richiesta di amicizia da parte di @$username rifiutata.",
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

  showDialogFriendRequestRemoved(BuildContext context, String username) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Style.Colors.mainColor,
            title: Text("Rimozione collegamento",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w100)),
            content: Text(
                "Il collegamento con l'utente @$username è stato rimosso.",
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
