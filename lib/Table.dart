import 'package:farmwise_ai/Model/DataModel.dart';
import 'package:farmwise_ai/Model/Test.dart';
import 'package:flutter/material.dart';

class Records extends StatefulWidget {
  final List<DataModel> datalist;
  const Records({Key? key, required this.datalist}) : super(key: key);

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Current Temperature: 23 C"),
              Text("Current City: Kothrikalan"),
              DataTable(
                  columns: const [
                    DataColumn(
                        label: Text(
                      "F. Name",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      "Gender",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      "Area",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      "Address",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      "Date",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      "Video",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      "Latitude",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      "Longitude",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text(
                      "Image",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ))
                  ],
                  rows: widget.datalist
                      .map((data) => DataRow(cells: [
                            DataCell(Text(
                              data.name,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )),
                            DataCell(Text(
                              data.gender,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )),
                            DataCell(Text(
                              data.area,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )),
                            DataCell(Text(
                              data.address,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )),
                            DataCell(Text(
                              data.date,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )),
                            DataCell(Text(
                              data.videoname,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )),
                            DataCell(Text(
                              data.lat,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )),
                            DataCell(Text(
                              data.lng,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )),
                            DataCell(Text(
                              data.image,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )),
                          ]))
                      .toList()),
            ]),
      ),
    );
  }
}
