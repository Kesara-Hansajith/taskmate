import 'package:quickalert/quickalert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Receivemsg extends StatefulWidget {
  Receivemsg({super.key});
  @override
  State<Receivemsg> createState() => _ReceivemsgState();
}

class _ReceivemsgState extends State<Receivemsg> {
  final listMsg = FirebaseFirestore.instance
      .collection('message')
      .orderBy("date")
      .snapshots();
  String datetime = DateTime.now().toString();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'images/noise_image.webp',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 120,
          title: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Messages",
                    style: TextStyle(
                        color: Color(0xFF16056B),
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.search,
                          size: 20, color: Color(0xFF4B4646)),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "search",
                      style: TextStyle(fontSize: 15, color: Color(0xFF4B4646)),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.filter_list,
                          size: 25, color: Color(0xFF4B4646)),
                    )
                  ],
                ),
                height: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  border: Border.all(color: Color(0xFF4B4646)),
                ),
              )
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/noise_image.webp'),
                fit: BoxFit.cover),
          ),
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
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(right: 20, left: 20, top: 20),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: InkWell(
                                onTap: () async {},
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(docs[index]["image"]),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: CircleAvatar(
                                          backgroundColor: Color(0xFF0FBD00),
                                          radius: 5,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(docs[index]['date']),
                                  Text(
                                    docs[index]['text'],
                                    style: TextStyle(
                                        fontSize: 15, color: Color(0xFF4B4646)),
                                  ),
                                ],
                              ),
                              trailing: InkWell(
                                onTap: () async {
                                  deleteMsg(docs[index].id);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Color(0xFF16056B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }

  deleteMsg(String id) {
    FirebaseFirestore.instance.collection('message').doc(id).delete();
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Deleted',
      text: 'Message is permanently deleted',
      autoCloseDuration: const Duration(seconds: 10),
    );
  }
}
