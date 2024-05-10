// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resume_builder/core/model/resume_model.dart';
import 'package:resume_builder/utils/constant.dart';
import 'package:resume_builder/view/widget/common_snak_bar_widget.dart';
import 'package:resume_builder/view/widget/loading_widget.dart';

class AddResumeController extends GetxController {
  RxList<Resume> resumeDataList = <Resume>[].obs;

  ImagePicker picker = ImagePicker();
  var thumbnailImage = File('').obs;
  RxString thumbnailImagePath = "".obs;
  RxString thumbnailNetworkImagePath = "".obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController skillController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController universityNameController = TextEditingController();
  TextEditingController passingYearController = TextEditingController();
  TextEditingController educationDescriptionController = TextEditingController();

  pickImage() async {
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    print("pickedImage--->$pickedImage");
    if (pickedImage != null) {
      thumbnailNetworkImagePath.value = '';
      thumbnailImage.value = File(pickedImage.path);
      thumbnailImagePath.value = pickedImage.path;
      print("logoImage--->$thumbnailImage");
    } else {
      commonToast("Image not picked");
    }
  }

  FirebaseFirestore db = FirebaseFirestore.instance;

  addResumeToDataBase({
    required String location,
    required String name,
    required String profileImage,
    required String email,
    required String phoneNo,
    required String skill,
    required String designation,
    required String duration,
    required String companyName,
    required String description,
    required String qualification,
    required String passingYear,
    required String universityName,
    required String educationDescription,
  }) async {
    Loader.showLoader();

    final storageRef = FirebaseStorage.instance.ref();
    Reference? imagesRef = storageRef.child(AppConstant.resumeResume).child("${AppConstant.resumeThumbnail}_$name");
    print("thumbnail----$profileImage\n${profileImage.isURL}");
    try {
      await imagesRef.putFile(File(profileImage));
    } on FirebaseException catch (e) {
      print("path----${e.message}");
    }
    print("imagesRef----${imagesRef.name}");
    String thumbnailUrl = await imagesRef.getDownloadURL();

    print("thumbnailUrl----$thumbnailUrl");
    try {
      // db.collection(Prefs.getUserID()).doc(AppConstant.assetsTbl).set({
      // db.collection(AppConstant.resumeTbl).doc(AppConstant.resumeData).set({
      db.collection(AppConstant.resumeTbl).add({
        "profileImage": thumbnailUrl,
        "location": location,
        "name": name,
        "email": email,
        "phoneNo": phoneNo,
        "skill": skill,
        "designation": designation,
        "duration": duration,
        "companyName": companyName,
        "description": description,
        "qualification": qualification,
        "passingYear": passingYear,
        "universityName": universityName,
        "educationDescription": educationDescription,
      });
      commonToast(AppConstant.addResumeSuccess);
      getResumeData();
      // clear();
      // Get.back();
    } on FirebaseException catch (e) {
      print("path----${e.message}");
    }
    Loader.hideLoader();
  }

  getResumeData() async {
    Loader.showLoader();
    resumeDataList.clear();
    await db.collection(AppConstant.resumeTbl).get().then(
      (querySnapshot) {
        print("Successfully completed");
        print('response=================>::: ${querySnapshot.docs}');
        for (var docSnapshot in querySnapshot.docs) {
          print('-=-=================> ${docSnapshot.id} => ${jsonEncode(docSnapshot.data())}');
          print('-=-=================> ---- ${jsonEncode(docSnapshot.data())}');

          Resume assets = Resume.fromJson(docSnapshot.data());
          print('------?${assets.name}');
          resumeDataList.add(Resume(
            location: assets.location,
            name: assets.name,
            profileImage: assets.profileImage,
            email: assets.email,
            phoneNo: assets.phoneNo,
            skill: assets.skill,
            designation: assets.designation,
            duration: assets.duration,
            companyName: assets.companyName,
            description: assets.description,
            qualification: assets.qualification,
            passingYear: assets.passingYear,
            universityName: assets.universityName,
            educationDescription: assets.educationDescription,
          ));
          resumeDataList.refresh();
          print('---length---???${resumeDataList.length}');
          print('------???${resumeDataList.first.name}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    Loader.hideLoader();
  }

  clear() {
    nameController.clear();
    emailController.clear();
    phoneNoController.clear();
    locationController.clear();
    skillController.clear();
    designationController.clear();
    durationController.clear();
    companyNameController.clear();
    descriptionController.clear();
    qualificationController.clear();
    universityNameController.clear();
    passingYearController.clear();
    educationDescriptionController.clear();
  }
}
