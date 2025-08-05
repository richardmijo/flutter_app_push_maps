import 'package:flutter/material.dart';
import 'package:flutter_app_push_maps/features/maps/data/geo_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    final geoProvider = Provider.of<GeoProvider>(context, listen: false);
    _loadFuture = geoProvider.loadGeoObjects();
  }

  Future<void> _reloadData() async {
  final geoProvider = Provider.of<GeoProvider>(context, listen: false);

  final future = geoProvider.loadGeoObjects();

  // Esperas que se cargue
  await future;

  // Ya están disponibles los datos y puedes recorrerlos
  for (var obj in geoProvider.geoObjects) {
    print('ID: ${obj.id}');
    print('Nombre: ${obj.name}');
    print('Tipo: ${obj.type}');
    print('Coordenadas: ${obj.coordinates}');
    print('-------------');
  }

  // Luego actualizas el estado para que el UI use el nuevo Future
  setState(() {
    _loadFuture = future;
  });
}


  @override
  Widget build(BuildContext context) {
    final geoProvider = Provider.of<GeoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapa"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Recargar datos',
            onPressed: _reloadData,
          ),
        ],
      ),
      body: FutureBuilder(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final Set<Marker> markers = {};
          final Set<Polyline> polylines = {};
          final Set<Polygon> polygons = {};

          for (final obj in geoProvider.geoObjects) {
  if (obj.type == 'point' && obj.coordinates.isNotEmpty) {
    final coord = obj.coordinates.first;
    markers.add(Marker(
      markerId: MarkerId(obj.id.toString()),
      position: LatLng(coord[0], coord[1]), // ✅ LAT primero
      infoWindow: InfoWindow(title: obj.name),
    ));
  } else if (obj.type == 'route') {
    final List<LatLng> points = obj.coordinates
        .map((c) => LatLng(c[0], c[1])) // ✅ LAT primero
        .toList();
    polylines.add(Polyline(
      polylineId: PolylineId(obj.id.toString()),
      points: points,
      color: Colors.blue,
      width: 4,
    ));
  } else if (obj.type == 'polygon') {
    final List<LatLng> points = obj.coordinates
        .map((c) => LatLng(c[0], c[1])) // ✅ LAT primero
        .toList();
    polygons.add(Polygon(
      polygonId: PolygonId(obj.id.toString()),
      points: points,
      strokeColor: Colors.green,
      strokeWidth: 3,
      fillColor: Colors.green.withOpacity(0.3),
    ));
  }
}

          return GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(-3.99313, -79.20496), // UIDE Loja
              zoom: 15,
            ),
            markers: markers,
            polylines: polylines,
            polygons: polygons,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          );
        },
      ),
    );
  }
}
