import 'package:flutter/material.dart';
import 'package:flutter_hive_db/todo.dart';
import 'package:hive/hive.dart';


class AddTodo extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  Box todoBox = Hive.box<Todo>('todo');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(padding: const EdgeInsets.all(20),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(onPressed: (){
                     if(titleController.text != ''){
                       Todo newTodo = Todo(
                         title: titleController.text,
                         isCompleted: false,
                       );
                       todoBox.add(newTodo);
                       Navigator.pop(context);
                     }
                }, child: const Text("Add Todo",style: TextStyle(fontSize: 20),)),
              ),
           ],
         ),
      ),
      
    );
  }
}