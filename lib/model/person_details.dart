// To parse this JSON data, do
//
//     final personname = personnameFromJson(jsonString);

import 'dart:convert';

Personname personnameFromJson(String str) => Personname.fromJson(json.decode(str));

String personnameToJson(Personname data) => json.encode(data.toJson());

class Personname {
  bool? success;
  Data? data;
  String? message;
  dynamic errors;

  Personname({
    this.success,
    this.data,
    this.message,
    this.errors,
  });

  factory Personname.fromJson(Map<String, dynamic> json) => Personname(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
    "errors": errors,
  };
}

class Data {
  List<Lead>? leads;
  int? totalCount;
  int? totalPage;
  int? nextPageNo;
  dynamic previousPageNo;
  int? currentPage;

  Data({
    this.leads,
    this.totalCount,
    this.totalPage,
    this.nextPageNo,
    this.previousPageNo,
    this.currentPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    leads: json["leads"] == null ? [] : List<Lead>.from(json["leads"]!.map((x) => Lead.fromJson(x))),
    totalCount: json["total_count"],
    totalPage: json["total_page"],
    nextPageNo: json["next_page_no"],
    previousPageNo: json["previous_page_no"],
    currentPage: json["current_page"],
  );

  Map<String, dynamic> toJson() => {
    "leads": leads == null ? [] : List<dynamic>.from(leads!.map((x) => x.toJson())),
    "total_count": totalCount,
    "total_page": totalPage,
    "next_page_no": nextPageNo,
    "previous_page_no": previousPageNo,
    "current_page": currentPage,
  };
}

class Lead {
  int? id;
  dynamic source;
  CreatedUser? createdUser;
  AssignedUser? assignedUser;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? mobile;
  String? email;
  dynamic image;
  Interest? interest;
  Location? location;
  bool? isAssigned;
  Status? status;
  Priority? priority;
  int? fkCompany;
  int? createdBy;

  Lead({
    this.id,
    this.source,
    this.createdUser,
    this.assignedUser,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.mobile,
    this.email,
    this.image,
    this.interest,
    this.location,
    this.isAssigned,
    this.status,
    this.priority,
    this.fkCompany,
    this.createdBy,
  });

  factory Lead.fromJson(Map<String, dynamic> json) => Lead(
    id: json["id"],
    source: json["source"],
    createdUser: createdUserValues.map[json["created_user"]]!,
    assignedUser: assignedUserValues.map[json["assigned_user"]]!,
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    image: json["image"],
    interest: interestValues.map[json["interest"]]!,
    location: locationValues.map[json["location"]]!,
    isAssigned: json["is_assigned"],
    status: statusValues.map[json["status"]]!,
    priority: priorityValues.map[json["priority"]]!,
    fkCompany: json["fk_company"],
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "source": source,
    "created_user": createdUserValues.reverse[createdUser],
    "assigned_user": assignedUserValues.reverse[assignedUser],
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "name": name,
    "mobile": mobile,
    "email": email,
    "image": image,
    "interest": interestValues.reverse[interest],
    "location": locationValues.reverse[location],
    "is_assigned": isAssigned,
    "status": statusValues.reverse[status],
    "priority": priorityValues.reverse[priority],
    "fk_company": fkCompany,
    "created_by": createdBy,
  };
}

enum AssignedUser {
  TEST_SUBADMIN
}

final assignedUserValues = EnumValues({
  "Test Subadmin": AssignedUser.TEST_SUBADMIN
});

enum CreatedUser {
  CODEME_TEST
}

final createdUserValues = EnumValues({
  "Codeme Test": CreatedUser.CODEME_TEST
});

enum Interest {
  FLUTTER,
  PYTHON,
  UI_UX
}

final interestValues = EnumValues({
  "Flutter": Interest.FLUTTER,
  "Python": Interest.PYTHON,
  "UI/UX": Interest.UI_UX
});

enum Location {
  CALICUT,
  COCHIN,
  TRIAVANDRUM
}

final locationValues = EnumValues({
  "Calicut": Location.CALICUT,
  "Cochin": Location.COCHIN,
  "Triavandrum": Location.TRIAVANDRUM
});

enum Priority {
  WARM
}

final priorityValues = EnumValues({
  "Warm": Priority.WARM
});

enum Status {
  NEW
}

final statusValues = EnumValues({
  "New": Status.NEW
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
