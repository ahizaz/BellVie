class DoctorFollowupModel {
  final int id;
  final String doctorName;
  final String followupDate;
  final String followupTime;
  final String notes;
  final String treatmentDetails;
  final String createdAt;
  final int user;

  DoctorFollowupModel({
    required this.id,
    required this.doctorName,
    required this.followupDate,
    required this.followupTime,
    required this.notes,
    required this.treatmentDetails,
    required this.createdAt,
    required this.user,
  });

  factory DoctorFollowupModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DoctorFollowupModel(
      id: json['id'] ?? 0,
      doctorName: json['doctor_name']?.toString() ?? '',
      followupDate: json['followup_date']?.toString() ?? '',
      followupTime: json['followup_time']?.toString() ?? '',
      notes: json['notes']?.toString() ?? '',
      treatmentDetails:
          json['treatment_details']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      user: json['user'] ?? 0,
    );
  }
}