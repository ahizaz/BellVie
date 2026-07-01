class MedicalRecordModel {
  final int id;
  final String documentsType;
  final String document;
  final String? documentDetails;
  final String uploadedAt;

  MedicalRecordModel({
    required this.id,
    required this.documentsType,
    required this.document,
    this.documentDetails,
    required this.uploadedAt,
  });

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) {
    return MedicalRecordModel(
      id: json['id'] ?? 0,
      documentsType: json['documents_type'] ?? '',
      document: json['document'] ?? '',
      documentDetails: json['document_details'],
      uploadedAt: json['uploaded_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documents_type': documentsType,
      'document': document,
      'document_details': documentDetails,
      'uploaded_at': uploadedAt,
    };
  }
}