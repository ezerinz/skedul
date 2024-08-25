import 'package:skedul/shared/provider/realm/model.dart';

class TugasModel {
  String id;
  Makul makul;
  String judul;
  String deskripsi;
  DateTime deadline;

  TugasModel(
    this.id,
    this.makul,
    this.judul,
    this.deskripsi,
    this.deadline,
  );
}
