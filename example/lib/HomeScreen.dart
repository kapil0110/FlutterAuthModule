import 'package:example/MySharedPreferences.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Auth Plugin Demo"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Home Screen", style: TextStyle(fontSize: 20),),
            const SizedBox(height: 20,),
            MaterialButton(
              onPressed: (){
                MySharedPreferences().clearAll();
                Navigator.pushReplacementNamed(context, "/");
              },
              color: Colors.purple,
              minWidth: MediaQuery.of(context).size.width / 2,
              height: 55,
              child: const Text("Logout", style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
