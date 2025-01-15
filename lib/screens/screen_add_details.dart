import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jim_ghana/screens/screen_home.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../repository/provider/add_api_provider.dart';

class Screen3 extends StatefulWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  final _controllerUniqueID = TextEditingController();
  final _controllerVehicleNumber = TextEditingController();
  String uniqueId = '';
  String vehicleNumber = '';
  String capturedImagePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(50),
                child: buildImageContainer(),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: _controllerUniqueID,
                  textAlign: TextAlign.center,
                  // Set input type to number
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QRScanner(
                              onScan: (code) {
                                setState(() {
                                  _controllerUniqueID.text = code;
                                });
                              },
                              controllerUniqueID: _controllerUniqueID,
                            ),
                          ),
                        );
                      },
                      child: const Icon(Icons.qr_code),
                    ),
                    label: const Center(
                      child: Text('Unique ID'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: _controllerVehicleNumber,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    label: Center(
                      child: Text("Vehicle Number"),
                    ),
                  ),
                ),
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
                                    ),
                                  );
                                },
                                child: const Text('YES'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_controllerVehicleNumber.text.isNotEmpty &&
                          _controllerUniqueID.text.isNotEmpty) {
                        await JavaService().getPosts(
                            _controllerVehicleNumber.text,
                            _controllerUniqueID.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ScreenHome(),
                          ),
                        );
                      } else {
                        // Show a message or handle the case where one or both TextFields are empty
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: const Text(
                                'Please fill in both Unique ID and Vehicle Number.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text(
                      'ADD VEHICLE',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.white54),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageContainer() {
    return capturedImagePath.isNotEmpty
        ? Stack(
            children: [
              Image.file(
                File(capturedImagePath),
                height: 220,
                width: 600,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: -10,
                right: -10,
                child: ElevatedButton(
                  onPressed: () {
                    showImagePicker();
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    backgroundColor: Colors.black87,
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        : Container(
            height: 220,
            width: 600,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showImagePicker();
                      },
                      child: const Column(
                        children: [
                          SizedBox(height: 60),
                          Text(
                            'ADD QR & PHOTO',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> showImagePicker() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Open Camera'),
                onTap: () async {
                  final pickedFileCamera =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (pickedFileCamera != null) {
                    setState(() {
                      capturedImagePath = pickedFileCamera.path;
                    });
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Open Gallery'),
                onTap: () async {
                  final pickedFileGallery = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedFileGallery != null) {
                    setState(() {
                      capturedImagePath = pickedFileGallery.path;
                    });
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class QRScanner extends StatefulWidget {
  final TextEditingController controllerUniqueID;

  const QRScanner(
      {Key? key,
      required this.controllerUniqueID,
      required Null Function(dynamic code) onScan})
      : super(key: key);

  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isScanning = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: (controller) {
                this.controller = controller;
                controller.scannedDataStream.listen((scanData) {
                  // Extract numeric part from the scanned code
                  String numericPart = extractNumericPart(scanData.code!);

                  // Close the scanner and pass the data back to the previous screen
                  Navigator.pop(context);
                  setState(() {
                    widget.controllerUniqueID.text = '';
                    widget.controllerUniqueID.text = numericPart;
                  });
                });
              },
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     ElevatedButton(
          //       onPressed: () {
          //         if (isScanning) {
          //           controller?.pauseCamera(); // Stop scanning
          //         } else {
          //           controller?.resumeCamera(); // Start scanning
          //         }
          //         setState(() {
          //           isScanning = !isScanning;
          //         });
          //       },
          //       child: Text(isScanning ? 'Stop Scan' : 'Start Scan'),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  // Function to extract numeric part from a string
  String extractNumericPart(String input) {
    // Remove non-numeric characters from the input
    String numericPart = input.replaceAll(RegExp(r'[^0-9]'), '');
    return numericPart;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
