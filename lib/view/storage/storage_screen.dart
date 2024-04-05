import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/view/storage/storage_detail.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();

  void saveUser() async {
    String name = namecontroller.text.trim();
    String email = emailcontroller.text.trim();
    String age = agecontroller.text.trim();
    int agee = int.parse(age);
    if (name != "" && email != "" && profilePic != null) {
      UploadTask uploadtask = FirebaseStorage.instance
          .ref()
          .child('profilePictures')
          .child(const Uuid().v1())
          .putFile(profilePic!);

      StreamSubscription tasksubscription =
          uploadtask.snapshotEvents.listen((event) {
        double percentage = event.bytesTransferred / event.totalBytes * 100;
        log(percentage.toString());
      });

      TaskSnapshot taskSnapshot = await uploadtask;
      String downloadurl = await taskSnapshot.ref.getDownloadURL();
      tasksubscription.cancel();
      Map<String, dynamic> userdata = {
        "name": name,
        "email": email,
        "profilepic": downloadurl,
        "age": agee,
      };
      namecontroller.clear();
      emailcontroller.clear();
      agecontroller.clear();
      setState(() {
        profilePic = null;
      });
      FirebaseFirestore.instance.collection("users").add(userdata);
      log("User created!");
    } else {
      log("Please fill all the fields");
    }
  }

  File? profilePic;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                XFile? selectImage =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (selectImage != null) {
                  log('Image Selected!');
                  File connvertFile = File(selectImage.path);
                  setState(() {
                    profilePic = connvertFile;
                  });
                } else {
                  log("No Image Selected!");
                }
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        profilePic != null ? FileImage(profilePic!) : null,
                    radius: 50,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 80, top: 50),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.pink,
                      child: Icon(
                        Icons.edit,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextField(
              controller: namecontroller,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            TextField(
              controller: emailcontroller,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: agecontroller,
              decoration: const InputDecoration(hintText: 'Age'),
            ),
            TextButton(
              onPressed: () {
                saveUser();
              },
              child: const Text('Save'),
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> userdata =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                          return InkWell(
                            onTap: () {
                              Get.to(StorageDetail(
                                userdata: snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>,
                              ));
                            },
                            child: Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(userdata['profilepic']),
                                ),
                                title: Text(
                                  userdata["name"],
                                ),
                                subtitle: Text(
                                  userdata["email"],
                                ),
                                trailing: Text(userdata['age'].toString()),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Text("No Data ");
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
