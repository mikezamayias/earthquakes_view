import 'package:http/http.dart';

void main() async {
  Response response = await get(
    Uri.parse(
        'feed://www.geophysics.geol.uoa.gr/stations/maps/seismicity.xml'),
  );
  print(response.body);
}
