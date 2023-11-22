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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(70),
            child: Container(
              height: 100,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(child: Icon(Icons.qr_code)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: Text('Add QR & Photo')),
                  ),
                ],
              ),
            ),
          ),
          TextField(
              controller: _controllerUniqueID,
              decoration: const InputDecoration(
                  label: Center(
                child: Text("Unique ID"),
              ))),
          TextField(
              controller: _controllerVehicleNumber,
              decoration: const InputDecoration(
                  label: Center(
                child: Text("Vehicle Number"),
              ))),
          Row(
            children: [
              const SizedBox(width: 100),
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text(
                    'BACK',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white54),
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
                  await JavaService().getPosts(
                      _controllerVehicleNumber.text, _controllerUniqueID.text);
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
    );
  }
}
