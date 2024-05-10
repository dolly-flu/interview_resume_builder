import 'dart:convert';

class Resume {
  String? resumeKey;
  String? location;
  String? name;
  String? profileImage;
  String? email;
  String? phoneNo;
  String? skill;
  String? designation;
  String? duration;
  String? companyName;
  String? description;
  String? qualification;
  String? passingYear;
  String? universityName;
  String? educationDescription;

  Resume(
      {this.location,
      this.name,
      this.resumeKey,
      this.profileImage,
      this.email,
      this.phoneNo,
      this.skill,
      this.designation,
      this.duration,
      this.companyName,
      this.description,
      this.qualification,
      this.passingYear,
      this.universityName,
      this.educationDescription});

  Resume.fromJson(Map<String, dynamic> json) {
    profileImage = json["profileImage"];
    location = json["location"];
    name = json["name"];
    email = json["email"];
    phoneNo = json["phoneNo"];
    skill = json["skill"];
    designation = json["designation"];
    duration = json["duration"];
    companyName = json["companyName"];
    description = json["description"];
    qualification = json["qualification"];
    passingYear = json["passingYear"];
    universityName = json["universityName"];
    educationDescription = json["educationDescription"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data["profileImage"] = profileImage;
    data["location"] = location;
    data["name"] = name;
    data["email"] = email;
    data["phoneNo"] = phoneNo;
    data["skill"] = skill;
    data["designation"] = designation;
    data["duration"] = duration;
    data["companyName"] = companyName;
    data["description"] = description;
    data["qualification"] = qualification;
    data["passingYear"] = passingYear;
    data["universityName"] = universityName;
    data["educationDescription"] = educationDescription;
    return data;
  }
}
