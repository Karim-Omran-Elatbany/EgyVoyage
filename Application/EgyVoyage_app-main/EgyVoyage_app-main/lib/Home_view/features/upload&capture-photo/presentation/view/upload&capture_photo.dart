import 'dart:io';
import 'package:egyvoyage/Home_view/features/upload&capture-photo/presentation/view/ruslt-page.dart';
import 'package:egyvoyage/Home_view/features/upload&capture-photo/presentation/view/widget/class-text.dart';
import 'package:egyvoyage/Home_view/features/upload&capture-photo/presentation/view/widget/custom-button-model.dart';
import 'package:egyvoyage/Home_view/features/upload&capture-photo/presentation/view/widget/lacation-map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CapturePhoto extends StatefulWidget {
  const CapturePhoto({Key? key}) : super(key: key);
  static String id = 'CapturePhoto';

  @override
  State<CapturePhoto> createState() => _CapturePhotoState();
}

class _CapturePhotoState extends State<CapturePhoto> {
  late ImagePicker imagePicker;
  File? _image;
  String result = '';
  String location = '';
  String Deescription = '';
  late ImageLabeler imageLabeler;
  List<Map<String, String>> labelsInfo = [];
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    createLabeler();
  }

  @override
  void dispose() {
    super.dispose();
    imageLabeler.close();
  }

  _imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  _imgFromGallery() async {
    XFile? pickedFile =
    await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  createLabeler() async {
    final modelPath = await _getModel('assets/ml/converted_model.tflite');
    final options = LocalLabelerOptions(modelPath: modelPath);
    imageLabeler = ImageLabeler(options: options);
  }

  Future<String> _getModel(String asset) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$asset';
    await Directory(dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(asset);
      await file.writeAsBytes(
        byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
      );
    }
    return file.path;
  }

  doImageLabeling() async {
    labelsInfo.clear();

    final inputImage = InputImage.fromFile(_image!);
    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);

    if (labels.isEmpty) {
      print('No labels detected');
    }

    for (ImageLabel label in labels) {
      final text = label.label;
      final description =
          class_texts[text.trim()] ?? "No description available";
      final location = locationMap[text.trim()] ?? "No location available";

      labelsInfo.add({
        'text': text,
        'description': description,
        'location': location,
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/photo/White Photocentric Egypt Travel Package Promotion Flyer.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _imgFromGallery();
                        },
                        child: const Text(
                          'Choose',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.cyan,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      const Text(
                        ' Photo To Upload',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    'Or',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _imgFromCamera();
                    },
                    child: const Text(
                      'CapturePhoto',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 120,
              ),

              // Container to display picked image
              _image != null
                  ? Stack(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(_image!),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.close,
                      size: 36,
                      ),
                      color: Colors.red,
                      onPressed: () {
                        setState(() {
                          _image = null; // Remove the image
                        });
                      },
                    ),
                  ),
                ],
              )
                  : Container(),

              const SizedBox(
                height: 24,
              ),
              CustomButtonModel(
                text: 'Upload Photo',
                onPressed: () {
                  if (_image != null && !_isProcessing) {
                    setState(() {
                      _isProcessing = true;
                    });
                    doImageLabeling().then((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(
                              labelsInfo: labelsInfo, imageFile: _image),
                        ),
                      ).then((_) {
                        setState(() {
                          _isProcessing = false;
                        });
                      });
                    });
                  }
                },
                isProcessing: _isProcessing,
              ),
              const SizedBox(
                height: 103,
              ),
            ],
          ),
        ],
      ),
    );
  }


}
