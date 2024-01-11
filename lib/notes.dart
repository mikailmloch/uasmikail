import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uasmikail/firestore.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();
  void openNoteBox({String? docID}){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Masukkan Notes',
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                if (docID == null) {
                  firestoreService.addNote(textController.text);
                } else {
                  firestoreService.updateNote(docID, textController.text);
                }
                textController.clear();
                Navigator.pop(context);
              },
              child: Text("Add/Update")
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu CRUD",
        style: GoogleFonts.poppins(),),
          backgroundColor: Color.fromRGBO(116, 53, 242, 1),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotesStream(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List notesList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index){
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;
                String noteText = data['note'];

                return Card(
                  margin: EdgeInsets.all(8),
                  elevation: 4,
                  child: ListTile(
                      title: Text(noteText, style: TextStyle(fontSize: 18)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //update button
                          IconButton(
                            onPressed: () => openNoteBox(docID: docID),
                            icon: const Icon(Icons.edit, color: Colors.blue),
                          ),

                          //delete button
                          IconButton(
                            onPressed: () => firestoreService.deleteNote(docID),
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      )
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("Tidak ada Data", style: TextStyle(fontSize: 24)));
          }
        },
      ),
    );
  }
}
