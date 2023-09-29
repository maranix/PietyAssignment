import 'package:flutter/material.dart';
import 'package:piety_assignment/blocs/blocs.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late LocationBloc _locationBloc;

  @override
  void initState() {
    super.initState();

    _locationBloc = context.read<LocationBloc>();

    _locationBloc.add(const GetLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: const Center(
        child: LocationCoordinatesWidget(),
      ),
    );
  }
}

class LocationCoordinatesWidget extends StatelessWidget {
  const LocationCoordinatesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LocationBloc>().state;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('lat: ${state.lat}'),
        Text('lon: ${state.lon}'),
      ],
    );
  }
}
