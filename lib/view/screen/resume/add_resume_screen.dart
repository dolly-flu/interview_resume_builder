// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/core/controller/add_resume_controller.dart';
import 'package:resume_builder/core/model/resume_model.dart';
import 'package:resume_builder/utils/colors.dart';
import 'package:resume_builder/utils/images.dart';
import 'package:resume_builder/utils/text_style.dart';
import 'package:resume_builder/utils/validator.dart';
import 'package:resume_builder/view/widget/common_button.dart';
import 'package:resume_builder/view/widget/common_snak_bar_widget.dart';
import 'package:resume_builder/view/widget/common_space_divider_widget.dart';
import 'package:resume_builder/view/widget/common_text_field.dart';

class AddResumeScreen extends StatefulWidget {
  final bool isUpdate;
  final Resume? resume;

  const AddResumeScreen({super.key, required this.isUpdate, this.resume});

  @override
  State<AddResumeScreen> createState() => _AddResumeScreenState();
}

class _AddResumeScreenState extends State<AddResumeScreen> {
  AddResumeController addResumeController = Get.put(AddResumeController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isUpdate == true) {
      print(widget.resume!.profileImage!);
      addResumeController.nameController.text = widget.resume!.name!;
      addResumeController.thumbnailImagePath.value = widget.resume!.profileImage!;
      addResumeController.thumbnailNetworkImagePath.value = widget.resume!.profileImage!;
      addResumeController.thumbnailImage.value = File(widget.resume!.profileImage!);
      print(addResumeController.thumbnailNetworkImagePath.value);
      addResumeController.emailController.text = widget.resume!.email!;
      addResumeController.phoneNoController.text = widget.resume!.phoneNo!;
      addResumeController.locationController.text = widget.resume!.location!;
      addResumeController.skillController.text = widget.resume!.skill!;
      addResumeController.designationController.text = widget.resume!.designation!;
      addResumeController.durationController.text = widget.resume!.duration!;
      addResumeController.companyNameController.text = widget.resume!.companyName!;
      addResumeController.descriptionController.text = widget.resume!.description!;
      addResumeController.qualificationController.text = widget.resume!.qualification!;
      addResumeController.universityNameController.text = widget.resume!.universityName!;
      addResumeController.passingYearController.text = widget.resume!.passingYear!;
      addResumeController.educationDescriptionController.text = widget.resume!.educationDescription!;
    } else {
      addResumeController.thumbnailImage.value = File("");
      addResumeController.thumbnailImagePath.value = '';
      addResumeController.nameController.clear();
      addResumeController.emailController.clear();
      addResumeController.phoneNoController.clear();
      addResumeController.locationController.clear();
      addResumeController.skillController.clear();
      addResumeController.designationController.clear();
      addResumeController.durationController.clear();
      addResumeController.companyNameController.clear();
      addResumeController.descriptionController.clear();
      addResumeController.qualificationController.clear();
      addResumeController.universityNameController.clear();
      addResumeController.passingYearController.clear();
      addResumeController.educationDescriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: AppColor.cBackGround,
        appBar: AppBar(
          title: Text(widget.isUpdate ? "Update Resume" : 'New Resume'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Personal Detail",
                        style: pSemiBold18,
                      ),
                      verticalSpace(8),
                      horizontalDivider(),
                      verticalSpace(8),
                      Text(
                        "Profile ",
                        style: pMedium14,
                      ),
                      verticalSpace(8),
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColor.cBorder),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: addResumeController.thumbnailImage.value.path.isEmpty &
                                  addResumeController.thumbnailNetworkImagePath.value.isEmpty
                              ? CommonIconButton(
                                  icon: DefaultImages.uploadIcn,
                                  title: 'Upload File',
                                  onPressed: () {
                                    addResumeController.pickImage();
                                  },
                                  height: 37,
                                  width: 150,
                                  horizontal: 10,
                                  fontSize: 14,
                                )
                              : GestureDetector(
                                  onTap: () {
                                    addResumeController.pickImage();
                                  },
                                  child: ClipOval(
                                    child: Image(
                                      image: addResumeController.thumbnailNetworkImagePath.isNotEmpty
                                          ? NetworkImage(addResumeController.thumbnailNetworkImagePath.value)
                                          : FileImage(
                                              File(addResumeController.thumbnailImagePath.value),
                                            ) as ImageProvider,
                                      width: 120,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      verticalSpace(16),
                      CommonTextField(
                        controller: addResumeController.nameController,
                        labelText: 'Name',
                        hintText: 'Enter your Full name',
                        validator: (v) {
                          return Validator.validateName(v, "Name");
                        },
                      ),
                      verticalSpace(10),
                      CommonTextField(
                        controller: addResumeController.emailController,
                        labelText: 'Email-Id',
                        hintText: 'Enter your Email-Id',
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          return Validator.validateEmail(
                            v,
                          );
                        },
                      ),
                      verticalSpace(10),
                      CommonTextField(
                        controller: addResumeController.phoneNoController,
                        labelText: 'Phone No',
                        hintText: 'Enter your Phone no',
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          return Validator.validateMobile(
                            v,
                          );
                        },
                      ),
                      verticalSpace(10),
                      CommonTextField(
                        controller: addResumeController.locationController,
                        labelText: 'Location',
                        hintText: 'Enter your location',
                        keyboardType: TextInputType.name,
                        validator: (v) {
                          return Validator.validateName(v, "Location");
                        },
                      ),
                      verticalSpace(10),
                      Text(
                        "Skill",
                        style: pMedium14,
                      ),
                      verticalSpace(8),
                      horizontalDivider(),
                      verticalSpace(8),
                      CommonTextField(
                        controller: addResumeController.skillController,
                        labelText: '',
                        maxLine: 5,
                        hintText: 'Enter your skill',
                        validator: (v) {
                          return Validator.validateName(v, "Skill");
                        },
                      ),
                      verticalSpace(10),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColor.cBorder)),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Experience",
                              style: pSemiBold18,
                            ),
                            verticalSpace(8),
                            horizontalDivider(),
                            verticalSpace(8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: CommonTextField(
                                  controller: addResumeController.designationController,
                                  labelText: "Designation",
                                  hintText: 'Designation',
                                  validator: (v) {
                                    return Validator.validateName(v, "Designation");
                                  },
                                )),
                                horizontalSpace(10),
                                Expanded(
                                    child: CommonTextField(
                                  controller: addResumeController.durationController,
                                  labelText: "Duration",
                                  hintText: "Duration",
                                  validator: (v) {
                                    return Validator.validateRequired(v, string: "Duration");
                                  },
                                )),
                              ],
                            ),
                            verticalSpace(10),
                            CommonTextField(
                              controller: addResumeController.companyNameController,
                              hintText: 'Enter company name',
                              labelText: 'Company name',
                              validator: (v) {
                                return Validator.validateName(v, "Company name");
                              },
                            ),
                            verticalSpace(10),
                            CommonTextField(
                              controller: addResumeController.descriptionController,
                              hintText: 'Enter description',
                              labelText: 'Description',
                              validator: (v) {
                                return Validator.validateName(v, "Description");
                              },
                              maxLine: 4,
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(10),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColor.cBorder)),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Education",
                              style: pSemiBold18,
                            ),
                            verticalSpace(8),
                            horizontalDivider(),
                            verticalSpace(8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: CommonTextField(
                                  controller: addResumeController.qualificationController,
                                  labelText: "Qualification",
                                  hintText: 'Qualification',
                                  validator: (v) {
                                    return Validator.validateName(v, "Qualification");
                                  },
                                )),
                                horizontalSpace(10),
                                Expanded(
                                    child: CommonTextField(
                                  controller: addResumeController.passingYearController,
                                  labelText: "Passing year",
                                  hintText: "Enter Passing year",
                                  keyboardType: TextInputType.number,
                                  validator: (v) {
                                    return Validator.validateRequired(v, string: "Passing year");
                                  },
                                )),
                              ],
                            ),
                            verticalSpace(10),
                            CommonTextField(
                              controller: addResumeController.universityNameController,
                              labelText: "University name",
                              hintText: "Enter name of the University name",
                              validator: (v) {
                                return Validator.validateName(v, "University");
                              },
                            ),
                            verticalSpace(10),
                            CommonTextField(
                              controller: addResumeController.educationDescriptionController,
                              hintText: 'Enter description',
                              labelText: 'Description',
                              validator: (v) {
                                return Validator.validateName(v, "Description");
                              },
                              maxLine: 4,
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(16),
                      CommonButton(
                        title: widget.isUpdate ? 'Update' : 'Create',
                        onPressed: () {
                          if (addResumeController.thumbnailImage.value.path.isEmpty) {
                            commonToast("Please upload thumbnail");
                          } else {
                            if (formKey.currentState!.validate()) {
                              if (widget.isUpdate == true) {
                                addResumeController.updateResumeToDataBase(
                                  resumeKey: widget.resume!.resumeKey!,
                                  location: addResumeController.locationController.text.trim(),
                                  name: addResumeController.nameController.text.trim(),
                                  profileImage: addResumeController.thumbnailImagePath.value,
                                  email: addResumeController.emailController.text.trim(),
                                  phoneNo: addResumeController.phoneNoController.text.trim(),
                                  skill: addResumeController.skillController.text.trim(),
                                  designation: addResumeController.designationController.text.trim(),
                                  duration: addResumeController.durationController.text.trim(),
                                  companyName: addResumeController.companyNameController.text.trim(),
                                  description: addResumeController.descriptionController.text.trim(),
                                  qualification: addResumeController.qualificationController.text.trim(),
                                  passingYear: addResumeController.passingYearController.text.trim(),
                                  universityName: addResumeController.universityNameController.text.trim(),
                                  educationDescription: addResumeController.educationDescriptionController.text.trim(),
                                );
                              } else {
                                addResumeController.addResumeToDataBase(
                                  location: addResumeController.locationController.text.trim(),
                                  name: addResumeController.nameController.text.trim(),
                                  profileImage: addResumeController.thumbnailImagePath.value,
                                  email: addResumeController.emailController.text.trim(),
                                  phoneNo: addResumeController.phoneNoController.text.trim(),
                                  skill: addResumeController.skillController.text.trim(),
                                  designation: addResumeController.designationController.text.trim(),
                                  duration: addResumeController.durationController.text.trim(),
                                  companyName: addResumeController.companyNameController.text.trim(),
                                  description: addResumeController.descriptionController.text.trim(),
                                  qualification: addResumeController.qualificationController.text.trim(),
                                  passingYear: addResumeController.passingYearController.text.trim(),
                                  universityName: addResumeController.universityNameController.text.trim(),
                                  educationDescription: addResumeController.educationDescriptionController.text.trim(),
                                );
                              }
                            }
                          }
                        },
                      )
                    ],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
