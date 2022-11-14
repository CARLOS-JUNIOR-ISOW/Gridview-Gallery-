import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:isow_ds/widgets/texts/text.dart';

const primaryColor = Color.fromRGBO(83, 0, 254, 1);
const bgGrayColor = Color.fromRGBO(54, 54, 54, 1);

class FeedPostPage extends StatefulWidget {
  static const String route = "/post";
  const FeedPostPage({Key? key}) : super(key: key);

  @override
  _FeedPostPageState createState() => _FeedPostPageState();
}

class _FeedPostPageState extends State<FeedPostPage> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final photos = <File>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: primaryColor),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 180),
            child: ISowText.displayMediumBold('Nova Publicação'),
          ),
          Expanded(
            child: SizedBox(
              child: SingleChildScrollView(
                child: Wrap(
                  direction: Axis.horizontal,
                  children: listaMidia(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardCamera() {
    void openCamera() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CameraCamera(
            onFile: (file) {
              photos.add(file);
              Navigator.pop(context);
              setState(() {});
            },
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.23,
      width: MediaQuery.of(context).size.width * 0.28,
      decoration: BoxDecoration(
        color: bgGrayColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
          size: 40,
        ),
        onPressed: () => openCamera(),
      ),
    );
  }

  List<Widget> listaMidia() {
    return List.generate(
      15,
      (index) {
        return index == 0
            ? cardCamera()
            : GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/saveV');
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.23,
                  width: MediaQuery.of(context).size.width * 0.28,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(238, 238, 238, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.image),
                ),
              );
      },
    );
  }
}
