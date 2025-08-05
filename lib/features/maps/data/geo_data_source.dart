import 'package:flutter_app_push_maps/core/network/dio_client.dart';
import 'package:flutter_app_push_maps/features/maps/data/models/geo_object.dart';

class GeoDataSource {
  final DioClient dioClient;

  GeoDataSource({required this.dioClient});

  Future<List<GeoObject>> fetchGeoObjects() async {
    final response = await dioClient.instance.get('/geo');
    return List<GeoObject>.from(
      response.data.map((item) => GeoObject.fromJson(item)),
    );
  }
}
