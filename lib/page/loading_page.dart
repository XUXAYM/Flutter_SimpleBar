import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void loadingData() async{
    await Firebase.initializeApp();
    Navigator.popAndPushNamed(context, '/main');
  }

  @override
  void initState() {
    super.initState();
    loadingData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Simple Bar',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
