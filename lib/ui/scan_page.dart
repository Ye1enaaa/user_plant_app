import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:plant_dictionary/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plant_dictionary/models/plant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key,}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}
//edited
class _ScanPageState extends State<ScanPage> {

  CollectionReference reference = FirebaseFirestore.instance.collection('plant_list');
  
  String imageUrl='';

  Future pickImage()async{
   ImagePicker imagePicker = ImagePicker();
   XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
   //print('${file?.path}');

   if(file==null) return;

   String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();


   //root of firebase directory
   Reference referenceRoot = FirebaseStorage.instance.ref();
   Reference referenceDirImages = referenceRoot.child('data');
   Reference referenceImagetoUpload = referenceDirImages.child(uniqueFileName);

   try{
    //Store File
   await referenceImagetoUpload.putFile(File(file.path));
   //Get URL
   imageUrl = await referenceImagetoUpload.getDownloadURL();
   }catch(error){
    //
   }

   Map <String,String> datatoSend = {
    'image': imageUrl
   };

  reference.add(datatoSend);
  // print(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Constants.primaryColor.withOpacity(.15),
                      ),
                      child: Icon(
                        Icons.close,
                        color: Constants.primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      debugPrint('favorite');
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Constants.primaryColor.withOpacity(.15),
                      ),
                      child: IconButton(
                        onPressed: () {
                        },
                        icon: Icon(
                          Icons.share,
                          color: Constants.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Positioned(
            top: 100,
            right: 20,
            left: 20,
            child: GestureDetector(
              onTap: (){
                print('Camera Page');
                pickImage();
              },
              child: Container(
                width: size.width * .8,
                height: size.height * .8,
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/code-scan.png',
                        height: 100,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Tap to Scan',
                        style: TextStyle(
                          color: Constants.primaryColor.withOpacity(.80),
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}