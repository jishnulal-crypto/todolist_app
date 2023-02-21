import 'package:flutter/material.dart';
import 'package:note_keeper/database/data_base_helper.dart';
import 'package:note_keeper/database/model_class.dart';
import 'package:note_keeper/screens/add_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataBaseHelper dataBaseHelper = DataBaseHelper();
  late List<Note> noteList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Note',
          style: TextStyle(color: Colors.black),
        ),
        leading: SizedBox(),
        elevation: 5,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return AddNoteScreen(
              appBarText: 'Add Note',
              noteList: noteList,
            );
          })));
        },
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
            future: dataBaseHelper.getDataFromDb(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                noteList = snapshot.data as List<Note>;
                return GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    shrinkWrap: true,
                    itemCount: noteList == null ? 0 : noteList.length,
                    itemBuilder: ((context, index) {
                      Note one = noteList[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(10)),
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                one.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(one.description),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        titleController.text = one.title;
                                        descriptionController.text =
                                            one.description;
                                        note = one;
                                        updateIndex = index;
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: ((context) {
                                          return AddNoteScreen(
                                            appBarText: 'Edit Note',
                                            noteList: noteList,
                                          );
                                        })));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.orange,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        deleteDataBaseData(context, index);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.red,
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }));
              }
              return Text('');
            })),
      ),
    );
  }

  void deleteDataBaseData(BuildContext context, index) {
    Note one = noteList[index];
    dataBaseHelper.deleteData(one.id!);
    setState(() {
      noteList.removeAt(index);
    });
  }
}
