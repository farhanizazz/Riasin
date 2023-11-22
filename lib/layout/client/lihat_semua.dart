import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riasin_app/Url.dart';
import 'package:riasin_app/component/SelectMultipleChip.dart';
import 'package:riasin_app/component/item_mua.dart';

import 'detail_mua.dart';

class LihatSemua extends StatefulWidget {
  const LihatSemua({super.key, this.data});

  final List? data;

  @override
  State<LihatSemua> createState() => _LihatSemuaState();
}

class _LihatSemuaState extends State<LihatSemua> {
  final dio = Dio();
  List? data;
  List? kecamatans;
  final _storage = const FlutterSecureStorage();
  bool _isLoading = true;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  RangeValues _currentRangeValues = const RangeValues(10000, 500000);
  int? _selectedKecamatanIndex;
  final _searchController = TextEditingController();

  void _fetchData(
      {String? search, int? wilayah, int? hargaMin, int? hargaMax}) async {
    Response res = await dio.post('$baseUrl/api/pencari-jasa-mua/search-mua',
        data: {
          'search': search,
          'wilayah': wilayah,
          'harga_min': hargaMin,
          'harga_max': hargaMax
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${await _storage.read(key: 'token')}'
          },
        ));
    setState(() {
      data = res.data['data'];
      _isLoading = false;
    });
  }

  void _fetchKecamatan() async {
    Response res = await dio.get('$baseUrl/api/kecamatans',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${await _storage.read(key: 'token')}'
          },
        ));
    setState(() {
      kecamatans = res.data['data'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchKecamatan();
    if (widget.data == null) {
      _fetchData();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawerEdgeDragWidth: 0,
      endDrawer: _isLoading
          ? null
          : Drawer(
              child: Scaffold(
                  bottomNavigationBar: Row(
                    children: [
                      Expanded(
                          child: Material(
                        color: const Color(0xFFC55977),
                        child: InkWell(
                          onTap: () {
                            _key.currentState!.closeEndDrawer();
                            setState(() {
                              _isLoading = true;
                            });
                            _fetchData(
                                search: _searchController.text,
                                wilayah: _selectedKecamatanIndex == null
                                    ? null
                                    : kecamatans![_selectedKecamatanIndex!]
                                        ['id'],
                                hargaMin: _currentRangeValues.start.round(),
                                hargaMax: _currentRangeValues.end.round());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Apply',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lokasi',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 200,
                          child: kecamatans == null
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SingleChildScrollView(
                                  child: Wrap(
                                      spacing: 4,
                                      children: kecamatans!
                                          .map((e) => SelectMultipleChip(
                                                label: e['nama_kecamatan'],
                                                selected:
                                                    _selectedKecamatanIndex ==
                                                        kecamatans!.indexOf(e),
                                                onPressed: () {
                                                  setState(() {
                                                    _selectedKecamatanIndex =
                                                        kecamatans!.indexOf(e);
                                                  });
                                                },
                                              ))
                                          .toList()),
                                ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          color: Color(0xffE1CCD2),
                          height: 1,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Harga",
                          style: TextStyle(fontSize: 16),
                        ),
                        RangeSlider(
                            values: _currentRangeValues,
                            max: 1000000,
                            divisions: 100,
                            labels: RangeLabels(
                              _currentRangeValues.start
                                  .round()
                                  .toString()
                                  .replaceAllMapped(
                                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                      (match) => '${match[1]},'),
                              _currentRangeValues.end
                                  .round()
                                  .toString()
                                  .replaceAllMapped(
                                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                      (match) => '${match[1]},'),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _currentRangeValues = value;
                              });
                            })
                      ],
                    ),
                  )),
            ),
      appBar: AppBar(
        actions: <Widget>[Container()],
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Lihat Semua",
        ),
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFFC55977),
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _isLoading = true;
                        });
                        _fetchData(
                            search: _searchController.text,
                            wilayah: _selectedKecamatanIndex == null
                                ? null
                                : kecamatans![_selectedKecamatanIndex!]['id'],
                            hargaMin: _currentRangeValues.start.round(),
                            hargaMax: _currentRangeValues.end.round());
                      },
                      decoration: const InputDecoration(
                        hintText: "Cari Jasa MUA",
                        hintStyle: TextStyle(fontSize: 12),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        _key.currentState!.openEndDrawer();
                      },
                      icon: const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isLoading
              ? Expanded(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: data != null
                          ? data!
                              .map(
                                (e) => SizedBox(
                                    width: double.infinity,
                                    child: ItemMUA(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => DetailMua(
                                                  idMua: e['id'],
                                                )));
                                      },
                                        muaName: e['nama_jasa_mua'],
                                        muaLocation: e['lokasi_jasa_mua'],
                                        muaImage: e['foto'],
                                        width: double.infinity)),
                              )
                              .toList()
                          : widget.data!
                              .map(
                                (e) => SizedBox(
                                    width: double.infinity,
                                    child: ItemMUA(
                                        muaName: e['nama'],
                                        muaLocation: e['lokasi'],
                                        muaImage: e['foto'],
                                        width: double.infinity)),
                              )
                              .toList(),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
