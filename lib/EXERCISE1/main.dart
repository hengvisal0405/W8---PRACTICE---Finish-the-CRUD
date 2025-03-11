import 'package:my_app/EXERCISE1/model/ride/location.dart';
import 'package:my_app/EXERCISE1/provider/ride_pref_provider.dart';
import 'model/ride_prefs/ride_pref.dart';
void main() {
  RidePreferencesService riderservice = RidePreferencesService();
  riderservice.addListener(ConsoleLogger());
  riderservice.setCurrentPreference(
    RidePreference(
      departure: Location(name: "Battambang", country:Country.cambodia), 
      departureDate: DateTime.now(), 
      arrival: Location(name: "Siem Reap", country:Country.cambodia), 
      requestedSeats: 2)
  );
}
