import 'package:geocoding/geocoding.dart' as geocoding;


void getLocationFromAddress(String city, String state, String zip) async{
  String address = "$city $state $zip";
  List<geocoding.Location> locations = await geocoding.locationFromAddress(address);
  return;
}