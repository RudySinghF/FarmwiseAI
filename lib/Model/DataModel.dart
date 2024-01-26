import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  final String? id;
  final String name;
  final String gender;
  final String area;
  final String address;
  final String date;
  final String videoname;
  final String lat;
  final String lng;
  final String image;
  const DataModel({
    this.id,
    required this.name,
    required this.gender,
    required this.area,
    required this.address,
    required this.date,
    required this.videoname,
    required this.lat,
    required this.lng,
    required this.image,
  });

  tojson() {
    return {
      "ID": id,
      "Name": name,
      "Gender": gender,
      "Address": address,
      "Area": area,
      "Date": date,
      "Video": videoname,
      "Latitude": lat,
      "Longitude": lng,
      "Image": image,
    };
  }

  factory DataModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentsnapshot) {
    final data = documentsnapshot.data()!;
    return DataModel(
        id: documentsnapshot.id,
        name: data["Name"],
        gender: data["Gender"],
        address: data["Address"],
        area: data["Area"],
        date: data["Date"],
        videoname: data["Video"],
        lat: data["Latitude"],
        lng: data["Longitude"],
        image: data["Image"]);
  }
}
