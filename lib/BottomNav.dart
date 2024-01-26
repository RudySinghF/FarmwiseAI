import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmwise_ai/DataForm.dart';
import 'package:farmwise_ai/Home.dart';
import 'package:farmwise_ai/Model/DataModel.dart';
import 'package:farmwise_ai/Model/Test.dart';
import 'package:farmwise_ai/Table.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  int _selectedIndex = 0;
  final _db = FirebaseFirestore.instance;
  static List<DataModel> dataList = [];

  @override
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    DataForm(
      filePath: "",
      latLng: LatLng(0, 0),
    ),
    Records(datalist: dataList)
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<DataModel>> fetchData() async {
    // Replace 'your_collection' with the name of your Firebase collection
    final snapshot = await _db.collection("User").get();
    final data = snapshot.docs.map((e) => DataModel.fromSnapshot(e)).toList();

    for (var document in snapshot.docs) {
      // Use the factory constructor to create a DataModel instance
      DataModel dataModel = DataModel.fromSnapshot(document);

      // Add the instance to the list
      dataList.add(dataModel);
    }

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          elevation: 0.0,
          type: BottomNavigationBarType.fixed,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_rounded), label: "Create"),
            BottomNavigationBarItem(icon: Icon(Icons.folder), label: "Result")
          ]),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color.fromARGB(255, 15, 82, 182),
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: ((context) => quizcreator())));
      //   },
      // ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
