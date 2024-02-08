// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class EmergencyCase {
  String id;
  String name;
  String address;
  String phoneNumber;
  String caseDetail;
  List<File>? images;
  String notes;
  EmergencyCase({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.caseDetail,
    this.images,
    required this.notes,
  });
}
