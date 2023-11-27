import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:appcrudsqlite/data/dbjogador.dart';

class EditJogador extends StatefulWidget {
  int rollno;

  EditJogador({required this.rollno}); //constructor for class

  @override
  State<StatefulWidget> createState() {
    return _EditJogador();
  }
}

class _EditJogador extends State<EditJogador> {
  TextEditingController nomejogador = TextEditingController();

  TextEditingController timejogador = TextEditingController();

  TextEditingController camisetajogador = TextEditingController();

  TextEditingController patrociniojogador = TextEditingController();

  TextEditingController posicaojogador = TextEditingController();

  TextEditingController rollno = TextEditingController();

  Dbjogador mydb = new Dbjogador();

  @override
  void initState() {
    mydb.open();

    Future.delayed(Duration(milliseconds: 500), () async {
      var data = await mydb.getjogador(
          widget.rollno); //widget.rollno is passed paramater to this class

      if (data != null) {
        nomejogador.text = data["nome"];

        timejogador.text = data["time"];

        camisetajogador.text = data["camiseta"];

        patrociniojogador.text = data["patrocinio"];

        posicaojogador.text = data["posicao"];

        rollno.text = data["roll_no"].toString();

        setState(() {});
      } else {
        print("Não encontrado dados com roll no: " + widget.rollno.toString());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Jogadores"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: nomejogador,
                decoration: InputDecoration(
                  hintText: "Nome",
                ),
              ),
              TextField(
                controller: timejogador,
                decoration: InputDecoration(
                  hintText: "Time",
                ),
              ),
              TextField(
                controller: camisetajogador,
                decoration: InputDecoration(
                  hintText: "Camiseta",
                ),
              ),
              TextField(
                controller: patrociniojogador,
                decoration: InputDecoration(
                  hintText: "Patrocinio",
                ),
              ),
              TextField(
                controller: posicaojogador,
                decoration: InputDecoration(
                  hintText: "Posição",
                ),
              ),
              TextField(
                controller: rollno,
                decoration: InputDecoration(
                  hintText: "Roll No.",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "UPDATE jogador SET nomejogador = ?, timejogador = ?, camisetajogador = ?, patrociniojogador = ?, posicaojogador = ? roll_no = ? WHERE roll_no = ?",
                        [
                          nomejogador.text,
                          timejogador.text,
                          camisetajogador.text,
                          patrociniojogador.text,
                          posicaojogador.text,
                          rollno.text,
                          widget.rollno
                        ]);

                    //update table with roll no.

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Livro Alterado!")));
                  },
                  child: Text("Alterar Livro")),
            ],
          ),
        ));
  }
}
