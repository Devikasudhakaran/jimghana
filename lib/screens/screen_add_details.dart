import 'package:flutter/material.dart';
import 'package:jim_ghana/screens/screen_home.dart';

import '../repository/provider/add_api_provider.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  final _controllerUniqueID = TextEditingController();
  final _controllerVehicleNumber = TextEditingController();
  String uniqueId = '';
  String vehicleNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(50),
              child: Container(
                height: 200,
                width: 600,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(child: Icon(Icons.qr_code)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(child: Text('Add QR & Photo')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                    controller: _controllerUniqueID,
                    decoration: const InputDecoration(
                        label: Center(
                      child: Text("Unique ID"),
                    ))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                  controller: _controllerVehicleNumber,
                  decoration: const InputDecoration(
                      label: Center(
                    child: Text("Vehicle Number"),
                  ))),
            ),
            Row(
              children: [
                const SizedBox(width: 50),
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: ElevatedButton(
                    child: Text(
                      'BACK',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.white54),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: const Text(
                              'Are you sure you want to close without saving?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('CANCEL'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ScreenHome(),
                                    ));
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await JavaService().getPosts(_controllerVehicleNumber.text,
                        _controllerUniqueID.text);
                    // print('hello');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScreenHome(),
                      ),
                    );
                  },
                  child: Text(
                    'ADD VEHICLE',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white54),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
