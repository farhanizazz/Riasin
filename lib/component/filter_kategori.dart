import 'package:flutter/material.dart';

class FilterKategori extends StatefulWidget {
  FilterKategori({
    super.key,
    required this.ArrayData,
    required this.nama,
    required this.value,
    required this.onSelected,
  });

  final List<String> ArrayData;
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
          color: widget.ArrayData.contains(widget.value)
              ? const Color(0xffffffff)
              : const Color(0xffC55977),
          fontWeight: FontWeight.w600,
        ),
      ),
      selected: widget.ArrayData.contains(widget.value),
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
