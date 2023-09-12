import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:taskmate/profile/freelancer/user_model.dart';

class Chatscreen extends StatefulWidget {
  late final UserModel user;
  final String? profilePhotoUrl;
  final String? firstName;
  Chatscreen({
    required this.user,
    this.profilePhotoUrl,
    this.firstName,
  });
  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  final listMsg = FirebaseFirestore.instance
      .collection('inbox')
      .orderBy("date", descending: false)
      .snapshots();
  String datetime = DateTime.now().toString();
  final messageController = TextEditingController();
  bool isOdd = true;
  DateTime now = DateTime.now();
  final CollectionReference collRef =
      FirebaseFirestore.instance.collection("inbox");
  final CollectionReference coll =
      FirebaseFirestore.instance.collection("message");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () async {},
                  child: const Icon(Icons.arrow_back_ios,
                      color: Color(0xFF4B4646)),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(widget.profilePhotoUrl ?? ''),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: Color(0xFF0FBD00),
                          radius: 5,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  (widget.firstName ?? ''),
                  style: const TextStyle(
                    color: Color(0xFF4B4646),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () async {},
              child: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF4F7F9),
      ),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: StreamBuilder(
                stream: listMsg,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("connection error");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }
                  var docs = snapshot.data!.docs;
                  return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) => Align(
                            alignment: index.isOdd
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Card(
                                  color: index.isOdd
                                      ? Color.fromARGB(20, 75, 70, 70)
                                      : Color(0xFFB4D7FE),
                                  margin: const EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: SizedBox(
                                    width: 230,
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            docs[index]['text'],
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xFF4B4646),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  docs[index]['date'],
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Color(0xFF4B4646)),
                                                ),
                                                const SizedBox(
                                                  width: 2,
                                                ),
                                                const Icon(
                                                  Icons.done_all,
                                                  color: Color(0xFF4B4646),
                                                  size: 15,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    deleteMsg(docs[index].id);
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: index.isOdd
                                                        ? const Color.fromARGB(
                                                            20, 75, 70, 70)
                                                        : const Color(
                                                            0xFFB4D7FE),
                                                    size: 10,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          ));
                },
              ),
            )),
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF000000)),
                  borderRadius: const BorderRadius.all(Radius.circular(50.0))),
              child: Row(
                children: [
                  const Icon(Icons.attach_file, color: Color(0xFF4B4646)),
                  Flexible(
                    child: TextField(
                      maxLines: null,
                      controller: messageController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Message"),
                    ),
                  ),
                  Icon(Icons.tag_faces, color: Color(0xFF4B4646)),
                  IconButton(
                    onPressed: () {
                      collRef.add({
                        "text": messageController.text,
                        "date": DateFormat("hh:mm:ss a").format(DateTime.now()),
                      });
                      coll.add({
                        "text": messageController.text,
                        "date": DateTime.now().toString(),
                        "image": widget.profilePhotoUrl,
                        "name": widget.firstName,
                      });
                      messageController.clear();
                    },
                    icon: Icon(Icons.send, color: Color(0xFF4B4646)),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

deleteMsg(String id) {
  FirebaseFirestore.instance.collection('inbox').doc(id).delete();
}
