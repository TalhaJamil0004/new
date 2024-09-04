
// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:veterinary_application/components/mybutton.dart';
import 'package:veterinary_application/components/mytextformfield.dart';

class SellPage extends StatefulWidget {
  const SellPage({super.key});

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  final _formKey = GlobalKey<FormState>();

  final petCategoryController = TextEditingController();
  final petPriceController = TextEditingController();
  final petDetailController = TextEditingController();
  final petDescriptionController = TextEditingController();

  Uint8List? imageFiles;

  bool isLoading = false;
  double loadingValue = 0;

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final selectedImage = await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      final image = await selectedImage.readAsBytes();
      setState(() {
        imageFiles = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: "Selling Pet".text.xl2.bold.color(context.primaryColor).make(),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: context.primaryColor),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: isLoading
                ? Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: LinearProgressIndicator(
                        value: loadingValue,
                      ),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/sell.png",
                        height: 250,
                        width: 400,
                        fit: BoxFit.contain,
                      ),
                      "A Whole New World For Pets!"
                          .text
                          .xl2
                          .bold
                          .color(context.primaryColor)
                          .make(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 40.0, horizontal: 50.0),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Pet Images
                            ElevatedButton(
                              onPressed: _pickImages,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      6), // Rounded corners
                                ),
                              ),
                              child: 'Pick Images'
                                  .text
                                  .color(context.canvasColor)
                                  .make(),
                            ),
                            const SizedBox(height: 10),
                            Wrap(spacing: 5.0, runSpacing: 5.0, children: [
                              if (imageFiles != null) ...[
                                Image.memory(
                                  imageFiles!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ]
                            ]),
                            const SizedBox(height: 10),
                            // Pet Category
                            MyTextFormField(
                              controller: petCategoryController,
                              hintText: 'Pet Category',
                              obscureText: false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Pet Price
                            MyTextFormField(
                              controller: petPriceController,
                              hintText: 'Price',
                              obscureText: false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Pet Details
                            MyTextFormField(
                              controller: petDetailController,
                              hintText: 'Write Detail',
                              obscureText: false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyTextFormField(
                              controller: petDescriptionController,
                              hintText: 'Write Description',
                              obscureText: false,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            // Submit Button
                            MyButton(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  final email =
                                      prefs.getString("userEmail") ?? "";
                                  await addPetToFirestore(
                                      email, context, imageFiles!);
                                }
                              },
                              text: 'Submit',
                            ),
                            const SizedBox(
                              height: 80,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Future<String> uploadImagesToFirebaseStorage(
    String childName,
    Uint8List files,
  ) async {
    String downloadUrl = "";

    try {
      setState(() {
        loadingValue = 0.2;
      });
      debugPrint("In uploadImagesToFirebaseStorage function <<<--------");
      String fileName = '$childName/${DateTime.now().microsecondsSinceEpoch}';
      final ref = FirebaseStorage.instance.ref(fileName);
      final UploadTask task = ref.putData(files);
      final TaskSnapshot snapshot = await task;

      downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: e.toString().text.make()));
      setState(() {
        loadingValue = 0;
        isLoading = false;
      });
      return "";
    }
  }

  Future addPetToFirestore(
      String email, BuildContext context, Uint8List files) async {
    try {
      debugPrint("In addPetToFirestore function <<<--------");
      final petsUrl = await uploadImagesToFirebaseStorage("petsImages", files);
      debugPrint(
          "In addPetToFirestore function after uploadImagesToFirebasseStorage <<<--------");
      setState(() {
        loadingValue = 0.4;
      });

      Map<String, dynamic> data = {
        "id": DateTime.now().millisecondsSinceEpoch,
        "image": petsUrl,
        "email": email,
        "name": petCategoryController.text,
        "price": int.parse(petPriceController.text),
        "detail": petDetailController.text,
        "description": petDescriptionController.text,
      };
      setState(() {
        loadingValue = 0.7;
      });
      await FirebaseFirestore.instance.collection("sellingPet").add(data);
      setState(() {
        loadingValue = 1.0;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: "Pet added to sell successfully!".text.make()));
      Navigator.pop(context);
      setState(() {
        isLoading = false;
        loadingValue = 0;
      });
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red, content: e.toString().text.make()));
      setState(() {
        isLoading = false;
        loadingValue = 0;
      });
    }
  }
}
