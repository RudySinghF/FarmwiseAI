import 'dart:ffi';
import 'dart:io';

import 'package:farmwise_ai/BottomNav.dart';
import 'package:farmwise_ai/Controller/controller.dart';
import 'package:farmwise_ai/CreateVideo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';

class DataForm extends StatefulWidget {
  final String filePath;
  final LatLng latLng;

  const DataForm({Key? key, required this.filePath, required this.latLng})
      : super(key: key);

  @override
  State<DataForm> createState() => _DataFormState();
}

class _DataFormState extends State<DataForm> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  final select = ["Select", "Male", "Female"];
  String gender = "Select";
  String videoId = randomAlphaNumeric(20);
  final controller = Get.put(Formcontroller());
  String? videoFilePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateController.text = "";
    print(widget.filePath);
    print(widget.latLng);
  }

  String pickVideo() {
    String path = widget.filePath;
    return path;
  }

  void pickAndUploadVideo() async {
    videoFilePath = pickVideo();
    if (videoFilePath != null) {
      await uploadVideoToFirebase(videoFilePath!);
    }
  }

  Future<void> uploadVideoToFirebase(String filePath) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage.ref().child('videos/${videoId}.mp4');

    UploadTask uploadTask = storageReference.putFile(File(filePath));

    TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => Get.to(BottomNav()));

    if (taskSnapshot.state == TaskState.success) {
      Get.snackbar("Success", "Video uploaded to Firebase Storage",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(255, 130, 216, 133).withOpacity(0.1),
          colorText: Color.fromARGB(255, 22, 141, 26));
      String downloadURL = await storageReference.getDownloadURL();
      print("Download URL: $downloadURL");
    } else {
      Get.snackbar("Error", "Error uploading video to Firebase Storage",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Color.fromARGB(255, 244, 121, 113).withOpacity(0.1),
          colorText: Color.fromARGB(255, 164, 23, 23));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      height: MediaQuery.of(context).size.height * 0.080,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "Form",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              height: 1,
                              width: 80,
                              color: Colors.black38.withOpacity(0.2),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "F A R M E R   D A T A",
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              height: 1,
                              width: 80,
                              color: Colors.black38.withOpacity(0.2),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      // height: MediaQuery.of(context).size.height * 0.715,
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade600,
                                spreadRadius: 0.1,
                                blurRadius: 1)
                          ]),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Name",
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontSize: 13,
                                      // fontWeight: FontWeight.bold
                                    )),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 6,
                                        offset: Offset(0, 2))
                                  ],
                                ),
                                height: 40,
                                width: 265,
                                child: TextFormField(
                                  controller: controller.name,
                                  style: TextStyle(color: Colors.black87),
                                  decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      contentPadding:
                                          EdgeInsets.only(bottom: 8, left: 8),
                                      border: InputBorder.none,
                                      hintText: '',
                                      hintStyle: TextStyle(
                                          color: Colors.black38,
                                          fontFamily:
                                              GoogleFonts.nunito().fontFamily,
                                          fontSize: 15)),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Address",
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontSize: 13,
                                      // fontWeight: FontWeight.bold
                                    )),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 6,
                                        offset: Offset(0, 2))
                                  ],
                                ),
                                height: 80,
                                width: 265,
                                child: TextFormField(
                                  controller: controller.address,
                                  minLines: 1,
                                  maxLines: 5,
                                  style: TextStyle(color: Colors.black87),
                                  decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      contentPadding:
                                          EdgeInsets.only(bottom: 8, left: 8),
                                      border: InputBorder.none,
                                      hintText: '',
                                      hintStyle: TextStyle(
                                          color: Colors.black38,
                                          fontFamily:
                                              GoogleFonts.nunito().fontFamily,
                                          fontSize: 15)),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Date",
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontSize: 13,
                                      // fontWeight: FontWeight.bold
                                    )),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                height: 40,
                                width: 265,
                                child: TextFormField(
                                    style: TextStyle(color: Colors.black87),
                                    controller: dateController,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.calendar_today),
                                        alignLabelWithHint: true,
                                        contentPadding:
                                            EdgeInsets.only(bottom: 8, left: 8),
                                        border: InputBorder.none,
                                        hintText: 'Select Date',
                                        hintStyle: TextStyle(
                                            color: Colors.black38,
                                            fontFamily:
                                                GoogleFonts.nunito().fontFamily,
                                            fontSize: 15)),
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime
                                                  .now(), //get today's date
                                              firstDate: DateTime(
                                                  2000), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(2101));
                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd').format(
                                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2022-07-04
                                        //You can format date as per your need

                                        setState(() {
                                          dateController.text =
                                              formattedDate; //set foratted date to TextField value.
                                        });
                                      } else {
                                        print("Date is not selected");
                                      }
                                    }),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Gender",
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontSize: 13,
                                      // fontWeight: FontWeight.bold
                                    )),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              DropdownButton(
                                  value: gender,
                                  items: select
                                      .map((e) => DropdownMenuItem(
                                            child: Text(
                                              e,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily:
                                                      GoogleFonts.nunito()
                                                          .fontFamily,
                                                  fontSize: 15),
                                            ),
                                            value: e,
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      gender = val as String;
                                    });
                                  }),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Area (in acres)",
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontSize: 13,
                                      // fontWeight: FontWeight.bold
                                    )),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 6,
                                        offset: Offset(0, 2))
                                  ],
                                ),
                                height: 40,
                                width: 265,
                                child: TextFormField(
                                  controller: controller.area,
                                  style: TextStyle(color: Colors.black87),
                                  decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      contentPadding:
                                          EdgeInsets.only(bottom: 8, left: 8),
                                      border: InputBorder.none,
                                      hintText: '',
                                      hintStyle: TextStyle(
                                          color: Colors.black38,
                                          fontFamily:
                                              GoogleFonts.nunito().fontFamily,
                                          fontSize: 15)),
                                  validator: (value) {
                                    if (!value!.isNumericOnly) {
                                      return "Only Numbers are accepted";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Upload Video",
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.nunito().fontFamily,
                                      fontSize: 13,
                                      // fontWeight: FontWeight.bold
                                    )),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 6,
                                          offset: Offset(0, 2))
                                    ],
                                  ),
                                  height: 40,
                                  width: 265,
                                  child: GestureDetector(
                                    child: Center(
                                      child: Text(
                                        "Tap here",
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontFamily: GoogleFonts.nunito()
                                                .fontFamily),
                                      ),
                                    ),
                                    onTap: () {
                                      final route = MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (_) => Record(),
                                      );
                                      Navigator.push(context, route);
                                    },
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: SizedBox(
                            height: 40,
                            width: 100,
                            child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 25, 194, 191),
                                    fontFamily: GoogleFonts.rubik().fontFamily,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 255, 255),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 7),
                          child: SizedBox(
                            height: 40,
                            width: 100,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    Map<String, dynamic> user = {
                                      "Name": controller.name.text,
                                      "Address": controller.address.text,
                                      "Gender": gender,
                                      "Date": dateController.text.toString(),
                                      "Area": controller.area.text,
                                      "Video": "${videoId}.mp4",
                                      "Latitude":
                                          widget.latLng.latitude.toString(),
                                      "Longitude":
                                          widget.latLng.longitude.toString(),
                                    };

                                    Formcontroller.instance.setdata(user);
                                    pickAndUploadVideo();
                                  }
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    fontFamily: GoogleFonts.nunito().fontFamily,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 25, 194, 191),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
