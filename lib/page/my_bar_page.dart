import 'package:flutter/material.dart';

import 'page.dart';

class MyBarPage extends StatelessWidget with PageWithTitle {
  MyBarPage({this.title: ''}) : assert(title != null);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 64.0,
          ),
          Text(
            'Dmitry Markin',
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          Text(
            'FLUTTER DEVELOPER',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 16.0,
            width: 250.0,
            child: Divider(
              thickness: 2.0,
              color: Colors.teal.shade900,
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
            child: ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.teal.shade700,
              ),
              title: Text(
                '+7 (925) 369-74-66',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.teal.shade700,
                ),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
            child: ListTile(
              leading: Icon(
                Icons.email,
                color: Colors.teal.shade700,
              ),
              title: Text(
                'dima-markin-2000@yandex.ru',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.teal.shade700,
                ),
              ),
            ),
          ),
          SizedBox(height: 64.0,)
        ],
      ),
    );
  }
}
