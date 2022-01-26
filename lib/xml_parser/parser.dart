import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/earthquake_event.dart';

Future<List<EarthquakeEvent>> parser() async {
  final client = http.Client();

  List<EarthquakeEvent> data = await client
      .get(
    Uri.parse(
      'http://www.geophysics.geol.uoa.gr/stations/maps/seismicity.xml',
    ),
  )
      .then(
    (response) {
      return response.body;
    },
  ).then(
    (bodyString) {
      final channel = RssFeed.parse(bodyString);
      var earthquakes = List.generate(
        channel.items.length,
        (index) {
          RssItem item = channel.items[index];
          List<String> data = item.description!.split('<br>').sublist(1);
          return EarthquakeEvent(
            id: parseDateTime(data[0]).millisecondsSinceEpoch,
            date: parseDateTime(data[0]),
            latitude: parseLatitude(data[1]),
            longitude: parseLongitude(data[2]),
            depth: parseDepth(data[3]),
            magnitude: parseMagnitude(data[4]),
          );
        },
      );
      return earthquakes;
    },
  );

  for (EarthquakeEvent item in data) {
    addItemToFirestore(item);
  }

  return data;
}

addItemToFirestore(EarthquakeEvent earthquakeEvent) {
  return FirebaseFirestore.instance
      .collection('earthquakes')
      .doc(earthquakeEvent.id.toString())
      .get()
      .then((DocumentSnapshot ds) {
    if (!ds.exists) {
      FirebaseFirestore.instance
          .collection('earthquake-events')
          .doc(earthquakeEvent.id.toString())
          .set(earthquakeEvent.toMap());
    }
  });
}

DateTime parseDateTime(String element) {
  return DateFormat('dd-MMM-yyyy HH:mm:ss')
      .parse(element.split(' ').sublist(2, 4).join(' '), true)
      .toLocal();
}

double parseLatitude(String element) {
  RegExp regex = RegExp(r'\d+\.\d+');
  return double.parse(regex.firstMatch(element.trim())!.group(0)!);
}

double parseLongitude(String element) {
  RegExp regex = RegExp(r'\d+\.\d+');
  return double.parse(regex.firstMatch(element.trim())!.group(0)!);
}

double parseDepth(String element) {
  return double.parse(element.trim().split(' ')[1].replaceAll('km', ''));
}

double parseMagnitude(String data) {
  return double.parse(data.trim().split(' ')[1]);
}
