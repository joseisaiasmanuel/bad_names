import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votos: 5),
    Band(id: '2', name: 'Queen', votos: 1),
    Band(id: '3', name: 'herois de silecio', votos: 2),
    Band(id: '3', name: 'Bons Jovens', votos: 5)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                const Text("BandName", style: TextStyle(color:Colors.black)),
                
            centerTitle: true,
            elevation: 1,
            backgroundColor: Colors.white),
        body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (_, i) => _bandTitle(bands[i]),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            elevation: 1,
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: addNewBanda));
  }

  Widget _bandTitle(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction:DismissDirection.startToEnd,
      onDismissed: (direction){

        print("direction: ${direction}");
         print("id: ${band.id}");

      },
      background: Container(
        padding:const EdgeInsets.only(left:8.0),
        color: Colors.red,
        child: const Center(
            child: Text("Deleta", style:(TextStyle(color:Colors.white)))
        )
      ),
      child: ListTile(
          leading: CircleAvatar(
              child: Text(band.name.substring(0, 2)),
              backgroundColor: Colors.blue[200]),
          title: Text(band.name),
          trailing: Text("${band.votos}", style: const TextStyle(fontSize: 20.0)),
          
          onTap: () {
            print(band.name);
          }),
    );
  }

  addNewBanda() {
    final controllerText = TextEditingController();
    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (contex) {
            return AlertDialog(
              title: const Text('New band name'),
              content: TextField(controller: controllerText),
              actions: [
                MaterialButton(
                    child: const Text("Add"),
                    textColor: Colors.white,
                    elevation: 5.5,
                    color: Colors.blue,
                    onPressed: () => addNewList(controllerText.text))
              ],
            );
          });
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('Nem band Name:'),
            content: CupertinoTextField(
              controller: controllerText,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Add'),
                onPressed: () => addNewList(controllerText.text),
              ),
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text('Dimiss'),
                  onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }

  addNewList(String nome) {
    print(nome);

    if (nome.length > 1) {
      bands.add(Band(
        id: DateTime.now().toString(),
        name: nome,votos:1,
      ));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
