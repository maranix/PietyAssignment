import 'package:flutter/material.dart';
import 'package:piety_assignment/blocs/blocs.dart';
import 'package:piety_assignment/src/home/view/home_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late LocationBloc _locationBloc;

  void _showLocationDisabledDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text('Location service is disabled'),
          content: const Text(
              'Location service is required for this app to function properly.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async => await _locationBloc.openSettings(),
              child: const Text('Open'),
            ),
          ],
        );
      },
    );
  }

  void _showPermissionDeniedDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text('Permissions denied'),
          content: const Text(
              'Location permissions are required for this app to function properly.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async => await _locationBloc.openAppSettings(),
              child: const Text('Grant'),
            ),
          ],
        );
      },
    );
  }

  void _getLocation() {
    _locationBloc.add(const GetLocation());
  }

  @override
  void initState() {
    super.initState();

    _locationBloc = context.read<LocationBloc>();

    _locationBloc.add(const CheckLocationPermissions(request: true));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationBloc, LocationState>(
      listener: (context, state) {
        return switch (state.status) {
          LocationStatus.disabled => _showLocationDisabledDialog(context),
          LocationStatus.permissionsDenied =>
            _showPermissionDeniedDialog(context),
          LocationStatus.acquired => _getLocation(),
          _ => null,
        };
      },
      child: const HomeView(),
    );
  }
}
