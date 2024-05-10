// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:resume_builder/core/model/resume_model.dart';
import 'package:resume_builder/utils/colors.dart';
import 'package:resume_builder/utils/images.dart';
import 'package:resume_builder/utils/text_style.dart';
import 'package:resume_builder/view/widget/common_button.dart';
import 'package:resume_builder/view/screen/add_resume_screen.dart';
import 'package:resume_builder/core/controller/add_resume_controller.dart';
import 'package:resume_builder/view/widget/common_space_divider_widget.dart';

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
            : ListView.builder(
                itemCount: addResumeController.resumeDataList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  print("----------${addResumeController.resumeDataList.length}==");

                  var invoice = addResumeController.resumeDataList[index];
                  print(invoice);
                  print(invoice.companyName);
                  return invoiceDataWidget(
                    title: invoice.name??'',
                    subTitle: invoice.designation??"",
                    onTap: () {
                      // Get.to(
                      //       () => InvoiceDetailScreen(
                      //     currentIndex: index,
                      //     customer: customer,
                      //   ),
                      // );
                    },
                  );
                },
              );
      })),
    );
  }

  Widget invoiceDataWidget({
    String? title,
    String? subTitle,
    Function()? onTap,
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
                    child: Center(child: Text(subTitle!, style: pSemiBold16)),
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
                  // Text(
                  //   price!,
                  //   style: pRegular12.copyWith(color: AppColor.cDarkGreyFont),
                  // ),
                  // Text(
                  //   status!.capitalizeFirst!,
                  //   style: pMedium14.copyWith(color: status == 'Paid' ? AppColor.cGreenFont : AppColor.cYellowFont),
                  //   maxLines: 3,
                  //   softWrap: true,
                  // ),
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
