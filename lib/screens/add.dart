import 'package:flutter/material.dart';
import 'package:appcrudsqlite/data/dbjogador.dart';

import 'package:appcrudsqlite/screens/list.dart';

class Add extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Add();
  }
}

class _Add extends State<Add> {
  TextEditingController nomejogador = TextEditingController();

  TextEditingController timejogador = TextEditingController();

  TextEditingController camisetajogador = TextEditingController();

  TextEditingController patrociniojogador = TextEditingController();

  TextEditingController posicaojogador = TextEditingController();

  TextEditingController roll_no = TextEditingController();

  //test editing controllers for form

  Dbjogador mydb = Dbjogador(); //mydb new object from db.dart

  @override
  void initState() {
    mydb.open(); //initilization database

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Inserir jogador"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: nomejogador,
                decoration: const InputDecoration(
                  hintText: "Nome jogador",
                ),
              ),
              TextField(
                controller: timejogador,
                decoration: const InputDecoration(
                  hintText: "Time do jogador",
                ),
              ),
              TextField(
                controller: camisetajogador,
                decoration: const InputDecoration(
                  hintText: "Número da camiseta do jogador",
                ),
              ),
              TextField(
                controller: patrociniojogador,
                decoration: const InputDecoration(
                  hintText: "Patrocinador do jogador",
                ),
              ),
              TextField(
                controller: posicaojogador,
                decoration: const InputDecoration(
                  hintText: "Posição do jogador",
                ),
              ),
              TextField(
                controller: roll_no,
                decoration: const InputDecoration(
                  hintText: "Roll No",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "INSERT INTO jogador(nomejogador, timejogador, camisetajogador, patrociniojogador, posicaojogador, roll_no) VALUES (?, ?, ?, ?, ?, ?);",
                        [
                          nomejogador.text,
                          timejogador.text,
                          camisetajogador.text,
                          patrociniojogador.text,
                          posicaojogador.text,
                          roll_no.text
                        ]); //add student from form to database

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Jogador Adicionado")));

                    nomejogador.text = "";

                    timejogador.text = "";

                    camisetajogador.text = "";

                    patrociniojogador.text = " ";

                    posicaojogador.text = " ";

                    roll_no.text = " ";
                  },
                  child: Text("Salvar")),
            ],
          ),
        ));
  }
}
