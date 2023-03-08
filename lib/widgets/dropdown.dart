import 'package:cadbury/utils/extensions.dart';
import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final List<String> list;
  final void Function(String?) onChanged;

  const Dropdown({required this.list, required this.onChanged, super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) => DropdownButton<String>(
        value: dropdownValue ?? widget.list.first,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          widget.onChanged(value);
          dropdownValue = value!;
        },
        items: widget.list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value.capitalize()),
          );
        }).toList(),
      );
}
