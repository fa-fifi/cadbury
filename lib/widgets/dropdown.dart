import 'package:cadbury/utils/extensions.dart';
import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final String? initialValue;
  final List<String> list;
  final void Function(String?) onChanged;

  const Dropdown(
      {this.initialValue,
      required this.list,
      required this.onChanged,
      super.key});

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  late String? dropdownValue = widget.initialValue;

  @override
  Widget build(BuildContext context) => DropdownButton<String>(
      value: dropdownValue ?? widget.list.first,
      style: Theme.of(context).textTheme.bodyMedium,
      onChanged: (String? value) {
        widget.onChanged(value);
        dropdownValue = value!;
      },
      items: widget.list
          .map((String value) => DropdownMenuItem<String>(
              value: value, child: Text(value.capitalize())))
          .toList());
}
