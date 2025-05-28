// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:emergency_app/Provider/location_provider.dart';
import 'package:emergency_app/screens/processsing_screen.dart';
import 'package:emergency_app/widgets/form_field.dart';
import 'package:emergency_app/widgets/location_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
//import 'package:video_player/video_player.dart';

class EmergencyForm extends StatefulWidget {
  final String type;
  const EmergencyForm({required this.type, super.key});

  @override
  State<EmergencyForm> createState() => _EmergencyFormState();
}

class _EmergencyFormState extends State<EmergencyForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  CameraController? _cameraController;
  late Future<void> _initializeControllerFuture;
  File? _capturedImage;
  File? _recordedVideo;
  bool _isRecording = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LocationProvider>(context, listen: false).fetchLocation();
    });

    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _cameraController = CameraController(
        firstCamera,
        ResolutionPreset.ultraHigh,
      );

      _initializeControllerFuture = _cameraController!.initialize();
      await _initializeControllerFuture;
      setState(() {
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to initialize the camera: $e";
      });
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _capturePhoto() async {
    try {
      await _initializeControllerFuture;

      final image = await _cameraController!.takePicture();
      setState(() {
        _capturedImage = File(image.path);
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Error capturing photo: $e";
      });
    }
  }

  Future<void> _recordVideo() async {
    try {
      if (_isRecording) {
        final videoFile = await _cameraController!.stopVideoRecording();
        setState(() {
          _recordedVideo = File(videoFile.path);
          _isRecording = false;
          _errorMessage = null;
        });
      } else {
        await _cameraController!.startVideoRecording();
        setState(() {
          _isRecording = true;
          _errorMessage = null;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Error recording video: $e";
      });
    }
  }

  Widget _buildImageWidget() {
    if (kIsWeb) {
      return const Text(
        "Image preview is not supported on the web.",
        style: TextStyle(color: Colors.grey),
      );
    } else if (_capturedImage != null) {
      return Column(
        children: [
          const Text(
            'Captured Image:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                _capturedImage!,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        title: Center(
          child: Text(
            "${widget.type.toUpperCase()} FORM",
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Enter Your Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      FormFields(text: "Name", controller: _nameController),
                      const SizedBox(height: 16),
                      FormFields(
                        text: "Mobile Number",
                        controller: _mobileNumberController,
                      ),
                      const SizedBox(height: 16),
                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (_cameraController != null &&
                    _cameraController!.value.isInitialized &&
                    _capturedImage == null)
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: CameraPreview(_cameraController!),
                  )
                else if (_cameraController == null)
                  const Text('Camera not initialized'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _capturePhoto,
                      icon: const Icon(Icons.camera),
                      label: const Text('Capture Photo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _recordVideo,
                      icon: Icon(
                        _isRecording ? Icons.stop : Icons.videocam,
                      ),
                      label: Text(
                          _isRecording ? 'Stop Recording' : 'Record Video'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildImageWidget(),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    const LocationContainer(),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProcessingScreen(
                                type: widget.type,
                                name: _nameController.text,
                                mobile: _mobileNumberController.text,
                                imagePath: _capturedImage?.path ?? "",
                                videoPath: _recordedVideo?.path ?? "",
                              ),
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(width: 8),
                            Text("Submit"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
