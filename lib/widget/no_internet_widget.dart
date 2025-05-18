import 'package:flutter/material.dart';
///import 'package:rhytham/utils/gps_location_time.dart';

class NoInternetSheet extends StatelessWidget {
  const NoInternetSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Internet Connection required',
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
              'Oops! Looks like we need an internet connection to enhance your app experience. Please enable internet access on your device to unlock all features. Make sure you are connected to a Wi-Fi network or have mobile data enabled. Thank you!',
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
                'Retry',
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
