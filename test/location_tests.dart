import 'package:test/test.dart';
import 'package:weatherapp/models/location.dart';

void main() {
  group('Location Model Tests', () {
    test('Creating a Location object using the normal constructor', () {
      final location = getMockLocation();

      expect(location.state, 'Bend');
      expect(location.city, 'Oregon');
      expect(location.zip, '97702');
      expect(location.latitude, 44.058174);
      expect(location.longitude, -121.315308);
    });

    test('Creating a Location object from JSON', () {
      final json = {
        'state': 'Bend',
        'city': 'Oregon',
        'zip': '97702',
        'latitude': 44.058174,
        'longitude': -121.315308,
      };

      final location = Location.fromJson(json);

      expect(location.state, 'Bend');
      expect(location.city, 'Oregon');
      expect(location.zip, '97702');
      expect(location.latitude, 44.058174);
      expect(location.longitude, -121.315308);
    });

    test('Getting JSON data from a Location object', () {
      final location = getMockLocation();

      final json = location.toJson();

      expect(json['state'], 'Bend');
      expect(json['city'], 'Oregon');
      expect(json['zip'], '97702');
      expect(json['latitude'], 44.058174);
      expect(json['longitude'], -121.315308);
    });

    test('Comparing two locations for equality (equal example)', () {
      final location1 = getMockLocation();
      final location2 = getMockLocation();

      expect(location1, equals(location2));
    });

    test('Comparing two locations for equality (unequal example)', () {
      final location1 = getMockLocation();
      final location2 = Location(
        state: 'Portland',
        city: 'Oregon',
        zip: '97201',
        latitude: 45.5152,
        longitude: -122.6784,
      );

      expect(location1, isNot(equals(location2)));
    });
  });
}

Location getMockLocation() {
  return Location(
    state: 'Bend',
    city: 'Oregon',
    zip: '97702',
    latitude: 44.058174,
    longitude: -121.315308,
  );
}
