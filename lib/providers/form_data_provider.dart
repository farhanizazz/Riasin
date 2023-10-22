import 'dart:io';
import 'package:flutter/material.dart';

class FormData extends ChangeNotifier {
  String namaLengkap;
  String nomorTelepon;
  String tanggalLahir;
  String jenisKelamin;

  String namaMUA;
  String kecamatan;

  File? profilePicture;
  List<File>? pdfPortfolio;

  List<String> hari = [];
  String jumlahOrderan;

  List<String> kategori = [];

  FormData({
    this.namaLengkap = '',
    this.nomorTelepon = '',
    this.tanggalLahir = '',
    this.jenisKelamin = '',
    this.kecamatan = '',
    this.namaMUA = '',
    this.profilePicture,
    this.pdfPortfolio,
    this.jumlahOrderan = '',
  });

  void changeNamaLengkap(
    String namaLengkap,
  )  {
    this.namaLengkap = namaLengkap;
    notifyListeners();
  }

  void changeNomorTelepon(
    String nomorTelepon,
  )  {
    this.nomorTelepon = nomorTelepon;
    notifyListeners();
  }

  void changeTanggalLahir(
    String tanggalLahir,
  ) {
    this.tanggalLahir = tanggalLahir;
    notifyListeners();
  }

  void changeJenisKelamin(
    String jenisKelamin,
  ) {
    this.jenisKelamin = jenisKelamin;
    notifyListeners();
  }

  void changeKecamatan (String kecamatan) {
    this.kecamatan = kecamatan;
    notifyListeners();
  }

  void changeNamaMUA(String namaMUA) {
    this.namaMUA = namaMUA;
    notifyListeners();
  }

  void changeProfilePicture(File profilePicture) {
    this.profilePicture = profilePicture;
    notifyListeners();
  }

  void changePortofolio(List<File> pdfPortfolio) {
    this.pdfPortfolio = pdfPortfolio;
    notifyListeners();
  }

  void setHari(String hari) {
    if (this.hari.contains(hari)) {
      this.hari.remove(hari);
      notifyListeners();
      return;
    }
    this.hari.add(hari);
    notifyListeners();
  }

  void changeJumlahOrderan(String jumlahOrderan) {
    this.jumlahOrderan = jumlahOrderan;
    notifyListeners();
  }

  void setKategori(String kategori) {
    if (this.kategori.contains(kategori)) {
      this.kategori.remove(kategori);
      notifyListeners();
      return;
    }
    this.kategori.add(kategori);
    notifyListeners();
  }
}
