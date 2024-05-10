import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder/core/model/resume_model.dart';
import 'package:resume_builder/utils/colors.dart';
import 'package:resume_builder/utils/text_style.dart';
import 'package:resume_builder/view/widget/common_space_divider_widget.dart';

class ResumeDetailScreen extends StatelessWidget {
  final Resume? resume;

  const ResumeDetailScreen({super.key, this.resume});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.cBackGround,
      appBar: AppBar(
        title: Text(resume!.name!),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personal Detail",
              style: pSemiBold18,
            ),
            verticalSpace(8),
            horizontalDivider(),
            verticalSpace(8),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColor.cBorder)),
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(resume!.profileImage!),
                  ),
                  horizontalSpace(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resume!.name!,
                        style: pMedium12,
                      ),
                      Text(
                        resume!.email!,
                        style: pMedium12,
                      ),
                      Text(
                        resume!.phoneNo!,
                        style: pMedium12,
                      ),
                      Text(
                        resume!.location!,
                        style: pMedium12,
                      ),
                    ],
                  )
                ],
              ),
            ),
            verticalSpace(16),
            Text(
              "Skill",
              style: pSemiBold18,
            ),
            verticalSpace(8),
            horizontalDivider(),
            verticalSpace(8),
            Text(
              "${resume!.skill}",
              style: pMedium12,
            ),
            verticalSpace(16),
            Text(
              "Experience",
              style: pSemiBold18,
            ),
            verticalSpace(8),
            horizontalDivider(),
            verticalSpace(8),
            verticalSpace(16),
            Container(
              width: Get.width,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColor.cBorder)),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${resume!.companyName}", style: pMedium12,),
                  Text("Duration: ${resume!.duration}", style: pMedium12,),
                  Text("Designation: ${resume!.designation}", style: pMedium12,),
                  Text("Description: ${resume!.description}", style: pMedium12,),
                ],
              ),
            ),
            verticalSpace(16),
            Text(
              "Education",
              style: pSemiBold18,
            ),
            verticalSpace(8),
            horizontalDivider(),
            verticalSpace(8),
            Container(
              width: Get.width,
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColor.cBorder)),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${resume!.universityName}", style: pMedium12,),
                  Text("Duration: ${resume!.passingYear}", style: pMedium12,),
                  Text("Qualification: ${resume!.qualification}", style: pMedium12,),
                  Text("Description: ${resume!.educationDescription}", style: pMedium12,),
                ],
              ),
            ),

          ],
        ),
      )),
    );
  }
}
