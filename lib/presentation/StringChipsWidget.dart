import 'package:flutter/material.dart';

class StringChipsWidget extends StatefulWidget {
  final List<String> strings;
  final List<String> selectedStrings;
  final Function(List<String>) onSelectionChanged;
  final Color color;
  final double fontSize;

  const StringChipsWidget(
      {super.key,
      required this.strings,
      required this.selectedStrings,
      required this.onSelectionChanged,
      this.color = Colors.orangeAccent,
      this.fontSize = 16 });

  @override
  StringChipsWidgetState createState() => StringChipsWidgetState();
}

class StringChipsWidgetState extends State<StringChipsWidget> {
  final Set<String> _selectedList = {};

  void _onChipSelected(String name, bool selected) {
    setState(() {
      if (selected) {
        _selectedList.add(name);
      } else {
        _selectedList.remove(name);
      }
    });
    widget.onSelectionChanged(_selectedList.toList());
  }

  @override
  Widget build(BuildContext context) {
    _selectedList.clear();
    _selectedList.addAll(widget.selectedStrings);

    return Wrap(
      spacing: 8.0,
      children: List<Widget>.generate(
        widget.strings.length,
        (int index) {
          return ChoiceChip(
            label: Text(
              widget.strings[index],
              style: TextStyle(color: widget.color, fontSize: widget.fontSize),
            ),
            selected: _selectedList.contains(widget.strings[index]),
            onSelected: (bool selected) {
              _onChipSelected(widget.strings[index], selected);
            },
          );
        },
      ).toList(),
    );
  }
}
