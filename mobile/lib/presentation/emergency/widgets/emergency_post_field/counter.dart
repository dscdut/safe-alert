import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';

class CustomCounter extends StatefulWidget {
  final Function(int) onChangedValue;
  const CustomCounter({Key? key, required this.onChangedValue})
      : super(key: key);

  @override
  State<CustomCounter> createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (counter > 1) {
              widget.onChangedValue(counter - 1);
              setState(() {
                counter--;
              });
            }
          },
          icon: const Icon(Icons.remove),
        ),
        Text('$counter', style: context.bodyMedium),
        IconButton(
          onPressed: () {
            widget.onChangedValue(counter + 1);
            setState(() {
              counter++;
            });
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
