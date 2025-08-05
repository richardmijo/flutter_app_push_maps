import 'package:flutter/material.dart';
import 'package:flutter_app_push_maps/features/maps/data/models/geo_object.dart';
import '../data/geo_data_source.dart';


class GeoProvider with ChangeNotifier {
  final GeoDataSource dataSource;
  List<GeoObject> _geoObjects = [];

  List<GeoObject> get geoObjects => _geoObjects;

  GeoProvider(this.dataSource);

  Future<void> loadGeoObjects() async {
    _geoObjects = await dataSource.fetchGeoObjects();
    notifyListeners();
  }
}
