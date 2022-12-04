import 'dart:io';
import 'package:fishols/detail.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late bool _loading;
  File? _image;
  List? _outputs;
  bool f = false;
  final _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/images/degree.tflite",
      labels: "assets/images/labels.txt",
    );
  }

  pickImage() async {
    var image = await _imagePicker.getImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
  }

  pickGallery() async {
    var image = await _imagePicker.getImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image!);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _loading = true;
      _outputs = output!;
      f = true;
    });
    print(
      "${_outputs![0]["label"]}".replaceAll(RegExp(r'[0-9]'), ''),
    );
  }

  // var snackbar = const SnackBar(
  //   elevation: 10,
  //   backgroundColor: Colors.black,
  //   content: Text(
  //     "No Image !",
  //     style: TextStyle(
  //       color: Colors.white,
  //     ),
  //   ),
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.withOpacity(0.6),
        elevation: 10.0,
        title: Center(
          child: Text(
            widget.title,
            // style: GoogleFonts.lato(),
          ),
        ),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.gif"),
                fit: BoxFit.fill),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Card(
                elevation: 10.0,
                shadowColor: Colors.white,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: _image == null
                    ? SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                pickImage();
                              },
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: Card(
                                  color: Colors.grey.shade400,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Icon(
                                    Icons.my_library_add_outlined,
                                    size: 25.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            const Text(
                              "Upload an image",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ))
                    : SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                  height: 300,
                                  width: 300,
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            TextButton(
                                onPressed: () => setState(() {
                                      _image = null;
                                      _outputs == null;
                                      f = false;
                                      _loading = false;
                                    }),
                                child: const Icon(
                                  Icons.close_sharp,
                                  size: 25,
                                  color: Colors.black,
                                ))
                          ],
                        ),
                        height: 400,
                        width: MediaQuery.of(context).size.width - 25,
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
              _loading == false
                  ? ElevatedButton(
                      onPressed: () {
                        if (_image != null) {
                          classifyImage(_image!);
                        } else {
                          final snackBar = SnackBar(
                            content: const Text(
                              'No Image !',
                              // textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15.0),
                            ),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const Text(
                        "Predict",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            wordSpacing: 3.0),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          primary: Colors.grey.shade400,
                          onPrimary: Colors.black,
                          elevation: 6.0,
                          shadowColor: Colors.white),
                    )
                  : Container(),
              const SizedBox(
                height: 30,
              ),
              _outputs != null && f == true
                  ? SizedBox(
                      height: 80,
                      width: MediaQuery.of(context).size.width - 200,
                      child: Card(
                        elevation: 10.0,
                        // color: Colors.grey.shade400,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "${_outputs![0]["label"]}"
                                .replaceAll(RegExp(r'[0-9]'), ''),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              background: Paint()..color = Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Text(""),
              const SizedBox(
                height: 20,
              ),
              _loading == true
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Details(
                                s: "${_outputs![0]["label"]}"
                                    .replaceAll(RegExp(r'[0-9]'), ''))));
                      },
                      child: const Text(
                        "Details",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            wordSpacing: 3.0),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          primary: Colors.grey.shade400,
                          onPrimary: Colors.black,
                          elevation: 6.0,
                          shadowColor: Colors.white),
                    )
                  : Container(),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
