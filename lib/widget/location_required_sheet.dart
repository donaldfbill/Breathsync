import 'package:flutter/material.dart';
import 'package:rhytham/utils/gps_location_time.dart';

class OpenSettingAppSheet extends StatelessWidget {
  const OpenSettingAppSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Location Permission Required',
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
              'Oops! Looks like we need your location to enhance your app experience. '
                  'Please enable location permissions in your device settings to unlock all features. Go to Settings > App Permissions > Location. Thank you!',
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
              onPressed: () => GpsTime.openAppSetting().whenComplete(() => Navigator.of(context).pop()),
              child: const Text(
                'Open App Setting',
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
