import 'package:flutter/material.dart';

class FilterKategori extends StatefulWidget {
  FilterKategori({
    super.key,
    required this.kategori,
    required this.nama,
    required this.value,
    required this.onSelected,
  });

  final List<String> kategori;
  final String nama;
  final String value;
  final Function(bool) onSelected;

  @override
  State<FilterKategori> createState() => _FilterKategoriState();
}

class _FilterKategoriState extends State<FilterKategori> {
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      onSelected: widget.onSelected,
      label: Text(
        widget.nama,
        style: TextStyle(
          color: widget.kategori.contains(widget.value)
              ? const Color(0xffffffff)
              : const Color(0xffC55977),
          fontWeight: FontWeight.w600,
        ),
      ),
      selected: widget.kategori.contains(widget.value),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      side: const BorderSide(color: Colors.transparent),
      selectedColor: const Color(0xffC55977),
      backgroundColor: const Color(0xffE1CCD2),
      showCheckmark: false,
    );
  }
}
