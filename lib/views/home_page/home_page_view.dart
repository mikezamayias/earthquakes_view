import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earthquakes_view/models/earthquake_event.dart';
import 'package:earthquakes_view/xml_parser/parser.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const SelectableText('Earthquakes View'),
        ),
        body: FutureBuilder<List<EarthquakeEvent>>(
          future: parser(),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<EarthquakeEvent>> snapshot,
          ) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: SelectableText(
                      snapshot.data![index].date.toString(),
                    ),
                    subtitle: SelectableText(
                      '${snapshot.data![index].latitude.toString()} ${snapshot.data![index].longitude.toString()}',
                    ),
                    trailing: SelectableText(
                      snapshot.data![index].magnitude.toString(),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return SelectableText(
                '${snapshot.error}',
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

}
