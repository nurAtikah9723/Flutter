import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  DateTime _dueDate = new DateTime.now();
  String _dateText = '';

  String newTask = '';
  String note = '';

  Future<Null> _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2019),
      lastDate:  DateTime(2090)
    );

    if (picked != null) {
      setState(() {
          _dueDate=picked;
          _dateText= "${picked.day}/${picked.month}/${picked.year}"; 
      });
    }
  }
void _addData(){
  Firestore.instance.runTransaction((Transaction transaction) async{
    CollectionReference reference = Firestore.instance.collection('task');
    await reference.add({
      "title" : newTask,
      "duedate" : _dateText,
      "note" : note,
    });
  });
  Navigator.pop(context);
}
@override
  void initState() {
    super.initState();
    _dateText= "${_dueDate.day}/${_dueDate.month}/${_dueDate.year}";
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
                  child: Text("Add Task", style: new TextStyle(fontSize: 24.0, color: Colors.white),),
                  ),
                Icon(Icons.list,color: Colors.white,size: 30.0)
              ],
            )
          ),
          new Padding
          (
            padding: const EdgeInsets.all(16.0),
            child:TextField(
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
            padding: const EdgeInsets.all(8.0),
            child: new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: new Icon(Icons.date_range),
                ),
                new Expanded(child: Text("Due Date", style: new TextStyle(fontSize: 22.0, color: Colors.black54),)),
                new FlatButton(
                  onPressed: () =>_selectDueDate(context),
                  child: Text(_dateText , style: new TextStyle(fontSize: 22.0, color: Colors.black54),)),
              ],
            ),
          ),
          new Padding(
          padding: const EdgeInsets.all(16.0),
            child:TextField(
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
                    _addData();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 40.0),
                  onPressed: (){
                    //Navigator.pop(context);
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