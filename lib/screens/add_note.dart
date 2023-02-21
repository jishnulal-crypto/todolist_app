import 'package:flutter/material.dart';
import 'package:note_keeper/database/data_base_helper.dart';
import 'package:note_keeper/database/model_class.dart';
import 'package:note_keeper/screens/home_screen.dart';

TextEditingController titleController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
Note? note;
late int updateIndex;

class AddNoteScreen extends StatefulWidget {
  AddNoteScreen({super.key, required this.appBarText, required this.noteList});
  String appBarText;
  late List<Note> noteList;

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final DataBaseHelper dataBaseHelper = DataBaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appBarText,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
                  child: TextFormField(
                    validator: (val) =>
                        val!.isNotEmpty ? null : "Please fill the Title ",
                    controller: titleController,
                    cursorColor: Colors.yellow,
                    decoration: InputDecoration(
                        hintText: 'Title',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow, width: 3),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow, width: 3),
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.yellow[100]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: TextFormField(
                    validator: (val) =>
                        val!.isNotEmpty ? null : "Please fill the Description ",
                    controller: descriptionController,
                    minLines: 5,
                    maxLines: null,
                    cursorColor: Colors.yellow,
                    decoration: InputDecoration(
                        hintText: 'Description',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow, width: 3),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow, width: 3),
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.yellow[100]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              foregroundColor: Colors.black),
                          onPressed: () {
                            Navigator.push(context,MaterialPageRoute(builder: ((context) => HomeScreen())));
                            setState(() {
                              saveNote(context);
                              upDataInDataBase(context);
                            });
                          },
                          child: Text('Save')),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              foregroundColor: Colors.black),
                          onPressed: () {
                            setState(() {
                              titleController.clear();
                              descriptionController.clear();
                            });
                          },
                          child: Text('Clear')),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveNote(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (note == null) {
        Note oneData = Note(
            title: titleController.text,
            description: descriptionController.text);
        dataBaseHelper.insertDataToDb(oneData).then((value) =>
            {titleController.clear(), descriptionController.clear()});
      }
    }
  }

  void upDataInDataBase(BuildContext context) {
    if (note != null) {
      note!.title = titleController.text;
      note!.description = descriptionController.text;
      dataBaseHelper.updateNoteToDb(note!).then((value) => {
            setState(() {
              widget.noteList[updateIndex].title = titleController.text;
              widget.noteList[updateIndex].description =
                  descriptionController.text;
            }),
            titleController.clear(),
            descriptionController.clear(),
            note = null,
          });
    }
  }
}
