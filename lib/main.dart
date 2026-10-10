import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title:const Text("Блокнот")),
        body: Center(
          child: SizedBox(width:1000, height:500, child: FirstExampleWidget()
          ),
        ),
      ),
      title: "пупупупу",
      theme: ThemeData.dark()
    );
  }
}
class FirstExampleWidget extends StatefulWidget{
  const FirstExampleWidget({super.key});

  @override
  _FirstExampleWidgetState createState() => _FirstExampleWidgetState();
}

class _FirstExampleWidgetState extends State<FirstExampleWidget> {
  final TextEditingController _controller = TextEditingController();
  List<String> notes = [];
  int curId = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void deleteNote(int id){
    setState(() {
      notes.removeAt(id);
      curId = notes.length;
    });
  }

  void editNote(int id){
    setState(() {
      _controller.text = notes[id];
      notes.removeAt(id);
      curId=id;
    });
  }

  void _makeNote() {
    setState(() {
      if (_controller.text != "")
      {
      notes.insert(curId, _controller.text);
      _controller.clear();
      curId = notes.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> entry_list = List<Widget>.of({});
    for(int i = 0; i < notes.length; i++){
      entry_list.add(
          SizedBox(width:500, height:120,
              child:Column(spacing:10,
                children: [
                  Expanded(
                      child: SingleChildScrollView
                    (scrollDirection: Axis.vertical,
                      child:Text(notes[i]),
                      )
                  ),
                  Row
                    (spacing: 10,
                      children:
                  [
                    Expanded(
                        child:ElevatedButton(
                            onPressed: () {deleteNote(i);},
                            child: Text("Удалить"))
                      ),
                    Expanded(
                        child:ElevatedButton(
                          onPressed: () {editNote(i);},
                          child: Text("Изменить"))
                    )
                  ]
                  )
                ]
                )
          )
      );
    }
    return Column(
      spacing: 10,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Введите текст',
          ),
        ),
        ElevatedButton(onPressed: _makeNote,
        child: Text('Записать'),
        ),
        Expanded(child:
        ListView(children: entry_list)
        )
      ],
    );
  }
}
