import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';



class Teste extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Danger Is Near',theme: ThemeData(
      primarySwatch: Colors.green
    ),
    home: MyTestePage(title: 'Teste pingulin'),);
  }
}

class MyTestePage extends StatefulWidget{
  MyTestePage({Key key,this.title}): super(key:key);
  final String title;

  _MyTestePageState createState() => _MyTestePageState();
}

class _MyTestePageState extends State<MyTestePage>{
  int _counter = 0;
  String _nome = "Wesley";
  String _child = "Teste";

  final control = TextEditingController();

   void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return meuWidget2();
}

Widget teste(){
return Scaffold(
      appBar: AppBar(title: Text("Bem Vindo: $_nome"),),
      body: Center(child:GestureDetector(
      onTap: () => setState (() {_counter++;_nome = "Você clicou $_counter vezes";}),
      child: Image.asset('images/01.gif'),
      ),
    ),
      backgroundColor: Colors.red,
      );
  }


Widget meuWidget(){
  return Center(child: Container(
    decoration: BoxDecoration(
     color: const Color(0xff7c94b6),
     image: DecorationImage(
       image: ExactAssetImage('images/perfil.jpg'),
        fit: BoxFit.cover,
     ),
   ),
  )
  );
}

Widget meuWidget2(){
    return Scaffold(appBar: AppBar(title: Text("Teste de Backend"),),
    body: Column(children: <Widget>[
      Text('Teste Back end do $_nome'),
      Center (child: TextField(decoration: InputDecoration(labelText: 'Teste Backend2'),controller: control,)), 
      IconButton(icon: Image.asset('images/01.gif'),onPressed: (){setState((){_nome = control.text;});}),]
    ),
    );
}
}