import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EarthquakeData {
  final String date;
  final String time;
  final String coordinates;
  final String magnitude;
  final String depth;
  final String location;
  final String potential;

  EarthquakeData({
    required this.date,
    required this.time,
    required this.coordinates,
    required this.magnitude,
    required this.depth,
    required this.location,
    required this.potential,
  });

  factory EarthquakeData.fromJson(Map<String, dynamic> json) {
    return EarthquakeData(
      date: json['Tanggal'],
      time: json['Jam'],
      coordinates: json['Coordinates'],
      magnitude: json['Magnitude'],
      depth: json['Kedalaman'],
      location: json['Wilayah'],
      potential: json['Potensi'],
    );
  }
}

class EarthquakeList extends StatefulWidget {
  @override
  _EarthquakeListState createState() => _EarthquakeListState();
}

class _EarthquakeListState extends State<EarthquakeList> {
  late Future<List<EarthquakeData>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  Future<List<EarthquakeData>> fetchData() async {
    final response =
    await http.get(Uri.parse('https://data.bmkg.go.id/DataMKG/TEWS/gempaterkini.json'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['Infogempa']['gempa'];
      return jsonResponse.map((data) => new EarthquakeData.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Gempa Terkini',
          style: GoogleFonts.poppins(),),
        backgroundColor: Color.fromRGBO(116, 53, 242, 1),
      ),
      body: FutureBuilder<List<EarthquakeData>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<EarthquakeData>? data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(data[index].location),
                          subtitle: Text(
                              'Tanggal: ${data[index].date}\n'
                                  'Waktu: ${data[index].time}\n'
                                  'Koordinat: ${data[index].coordinates}\n'
                                  'Magnitude: ${data[index].magnitude}\n'
                                  'Kedalaman: ${data[index].depth}\n'
                                  'Potensi: ${data[index].potential}'
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
