import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
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
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserLocationWidget(),
          ],
        ),
      ),
    );
  }
}

class UserLocationWidget extends StatelessWidget {
  const UserLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final placemark =
        context.select<LocationBloc, LocationState>((bloc) => bloc.state).place;

    return switch (placemark) {
      Placemark p => Text('${p.locality}, ${p.country}'),
      _ => const Text('Somewhere on earth'),
    };
  }
}
