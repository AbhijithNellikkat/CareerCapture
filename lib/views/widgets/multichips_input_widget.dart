// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MultiChipsInputWidget extends StatefulWidget {
  final String label;
  final List<String> initialValues;
  final Function(List<String>) onSaved;

  const MultiChipsInputWidget({
    super.key,
    required this.label,
    this.initialValues = const [],
    required this.onSaved,
  });

  @override
  _MultiChipsInputWidgetState createState() => _MultiChipsInputWidgetState();
}

class _MultiChipsInputWidgetState extends State<MultiChipsInputWidget> {
  late TextEditingController _controller;
  final List<String> _chips = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _chips.addAll(widget.initialValues);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        InputDecorator(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: _chips.map((chip) {
              return Chip(
                
                backgroundColor: const Color.fromARGB(255, 112, 1, 1),
                label: Text(
                  chip,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                deleteIconColor: Colors.white,
                onDeleted: () {
                  setState(() {
                    _chips.remove(chip);
                    widget.onSaved(_chips);
                  });
                },
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Add ${widget.label}',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _chips.add(value);
                      widget.onSaved(_chips);
                      _controller.clear();
                    });
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(
                Icons.add,
                size: 25,
              ),
              onPressed: () {
                String value = _controller.text.trim();
                if (value.isNotEmpty) {
                  setState(() {
                    _chips.add(value);
                    widget.onSaved(_chips);
                    _controller.clear();
                  });
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
