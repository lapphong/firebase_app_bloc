import 'package:flutter/material.dart';

class StatusError extends StatelessWidget {
  const StatusError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/error.png',
            width: 75,
            height: 75,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 20.0),
          const Text(
            'Ooops!\nTry again',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}