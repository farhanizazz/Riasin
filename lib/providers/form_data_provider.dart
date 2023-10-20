import 'dart:io';
import 'package:flutter/material.dart';

class FormData extends ChangeNotifier {
  String namaLengkap;
  String nomorTelepon;
  String tanggalLahir;
  String jenisKelamin;

  File? profilePicture;
  File? pdfPortfolio;

  FormData({
    this.namaLengkap = '',
    this.nomorTelepon = '',
    this.tanggalLahir = '',
    this.jenisKelamin = '',
    this.profilePicture,
    this.pdfPortfolio,
  });

  void changeNamaLengkap(
    String namaLengkap,
  ) async {
    this.namaLengkap = namaLengkap;
    notifyListeners();
  }

  void changeNomorTelepon(
    String nomorTelepon,
  ) async {
    this.nomorTelepon = nomorTelepon;
    notifyListeners();
  }

  void changeTanggalLahir(
    String tanggalLahir,
  ) async {
    this.tanggalLahir = tanggalLahir;
    notifyListeners();
  }

  void changeJenisKelamin(
    String jenisKelamin,
  ) async {
    this.jenisKelamin = jenisKelamin;
    notifyListeners();
  }
}
