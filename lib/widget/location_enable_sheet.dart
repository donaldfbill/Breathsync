import 'package:flutter/material.dart';

class OpenLocationPermissionSheet extends StatelessWidget {
  const OpenLocationPermissionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Please enable location service',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15.0),
          const Padding(
            padding: EdgeInsets.only(right: 26.0, left: 26.0),
            child: Text(
              'Oops! Looks like we need your location to enhance your app experience. Please turn on location permissions Thank you!',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 15.0),
          Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Request again',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
