// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/core/model/resume_model.dart';
import 'package:resume_builder/utils/colors.dart';
import 'package:resume_builder/utils/images.dart';
import 'package:resume_builder/utils/text_style.dart';
import 'package:resume_builder/view/screen/resume/resume_detail_screen.dart';
import 'package:resume_builder/view/widget/common_button.dart';
import 'package:resume_builder/view/screen/resume/add_resume_screen.dart';
import 'package:resume_builder/core/controller/add_resume_controller.dart';
import 'package:resume_builder/view/widget/common_space_divider_widget.dart';
import 'package:resume_builder/view/widget/icon_and_image.dart';

class ViewResumeScreen extends StatefulWidget {
  ViewResumeScreen({super.key});

  @override
  State<ViewResumeScreen> createState() => _ViewResumeScreenState();
}

class _ViewResumeScreenState extends State<ViewResumeScreen> {
  AddResumeController addResumeController = Get.put(AddResumeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addResumeController.getResumeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      appBar: AppBar(
        title: Text("Resume "),
      ),
      body: SafeArea(child: Obx(() {
        print("----------${addResumeController.resumeDataList.length}");
        return addResumeController.resumeDataList.isEmpty
            ? noResumeFoundWidget()
            : Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: addResumeController.resumeDataList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    print("----------${addResumeController.resumeDataList.length}==");

                    var resume = addResumeController.resumeDataList[index];
                    print(resume);
                    print(resume.companyName);
                    return invoiceDataWidget(
                      title: resume.name ?? '',
                      subTitle: resume.designation ?? "",
                      onTap: () {
                        Get.to(() => ResumeDetailScreen(
                              resume: resume,
                            ));
                      },
                      deleteFun: () {
                        addResumeController.deleteResumeFromData(
                          resumeKey: resume.resumeKey!,
                          name: resume.name!,
                        );
                      },
                      editFun: () {
                        Get.to(
                          () => AddResumeScreen(
                            isUpdate: true,
                            resume: resume,
                          ),
                        );
                      },
                    );
                  },
                ),
              );
      })),
      floatingActionButton: Obx(() {
        return addResumeController.resumeDataList.isEmpty
            ? SizedBox()
            : FloatingActionButton(
                onPressed: () {
                  Get.to(() => AddResumeScreen(isUpdate: false));
                },
                child: Icon(
                  Icons.add,
                  color: AppColor.cWhiteFont,
                ),
                backgroundColor: AppColor.cGreenFont,
              );
      }),
    );
  }

  Widget invoiceDataWidget({
    String? title,
    String? subTitle,
    Function()? onTap,
    Function()? deleteFun,
    Function()? editFun,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.cTextField,
            border: Border.all(color: AppColor.cBorder),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(color: AppColor.cBorder, borderRadius: BorderRadius.circular(5)),
                    child: Center(child: Text(subTitle![0].capitalizeFirst!, style: pSemiBold16)),
                  ),
                  horizontalSpace(10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        style: pRegular12.copyWith(color: AppColor.cDarkGreyFont),
                      ),
                      Container(
                        // color: AppColor.cBorder,
                        width: Get.width / 2,
                        child: Text(
                          subTitle.capitalizeFirst!,
                          style: pMedium14,
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: deleteFun,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColor.cRedText,
                      child: assetSvdImageWidget(
                          image: DefaultImages.deleteIcn,
                          height: 14,
                          colorFilter: ColorFilter.mode(AppColor.cWhiteFont, BlendMode.srcIn)),
                    ),
                  ),
                  verticalSpace(8),
                  GestureDetector(
                    onTap: editFun,
                    child: CircleAvatar(
                        radius: 12,
                        backgroundColor: AppColor.themeGreenColor,
                        child: Icon(
                          Icons.edit,
                          color: AppColor.cWhiteFont,
                          size: 14,
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Center noResumeFoundWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              DefaultImages.noResumeImage,
              height: 250,
            ),
            verticalSpace(16),
            Text(
              "Resume that you've generated will be shown here.",
              style: pMedium14.copyWith(color: AppColor.cDarkGreyFont),
            ),
            verticalSpace(16),
            CommonIconButton(
              title: 'Add Resume',
              icon: DefaultImages.addImage,
              onPressed: () {
                Get.to(() => AddResumeScreen(
                      isUpdate: false,
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
