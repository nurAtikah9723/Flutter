import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditTask extends StatefulWidget {
  EditTask({this.title,this.note, this.index /*this.duedate*/});
  final String title;
  final String note;
  //final DateTime duedate;
  final index;
  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {

  TextEditingController controllerTitle;
  TextEditingController controllernote;

  String newTask = '';
  String note = '';

void _editTask(){
  Firestore.instance.runTransaction((Transaction transaction) async{
    DocumentSnapshot snapshot =
    await transaction.get(widget.index);
    await transaction.update(snapshot.reference, {
      "title" : newTask,
      "note": note,
    });
  });
  Navigator.pop(context);
}
@override
  void initState() {
    super.initState();

    controllerTitle = new TextEditingController(text: widget.title);
    controllernote = new TextEditingController(text: widget.note);
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    ( //appBar: AppBar(title: Text("hai"),),
    body: Column(
        children: <Widget>
        [
          Container
          (
            height: 200.0, //34.43
            width: double.infinity,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("img/bg.png"),fit: BoxFit.cover),
                                      color: Colors.pinkAccent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>
              [
                Text("My Task", style: new TextStyle
                (
                    color: Colors.white,
                    fontSize: 30.0,
                    letterSpacing: 2.0,
                    fontFamily: "Pacifico"),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text("Edit Task", style: new TextStyle(fontSize: 24.0, color: Colors.white),),
                  ),
                Icon(Icons.list,color: Colors.white,size: 30.0)
              ],
            )
          ),
          new Padding
          (
            padding: const EdgeInsets.all(16.0),
            child:TextField(
              controller: controllerTitle,
              onChanged:(String str){
                setState(() {
                 newTask = str; 
                });
              },
              decoration: new InputDecoration(
                icon: Icon(Icons.dashboard),
                hintText: "New Task",
                border: InputBorder.none
              ),
            style: new TextStyle(fontSize: 22.0, color: Colors.black),)
          ),
         
          new Padding(
          padding: const EdgeInsets.all(16.0),
            child:TextField(
              controller: controllernote,
              onChanged:(String str){
                setState(() {
                 note = str; 
                });
              },
              decoration: new InputDecoration(
                icon: Icon(Icons.note),
                hintText: "Note",
                border: InputBorder.none
              ),
            style: new TextStyle(fontSize: 22.0, color: Colors.black),)
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.check, size: 40.0),
                  onPressed: (){
                    _editTask();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 40.0),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                )
              ],
              ),
          )
        ],
      ),
    );
  }
}