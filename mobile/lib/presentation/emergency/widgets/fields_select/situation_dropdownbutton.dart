// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';

import 'package:flutter_template/data/dtos/emergency/emergency_case_dto.dart';

class SituationDropdownButton extends StatefulWidget {
  final void Function(Situation?) onChangeValue;
  const SituationDropdownButton({
    Key? key,
    required this.onChangeValue,
  }) : super(key: key);

  @override
  State<SituationDropdownButton> createState() =>
      _SituationDropdownButtonState();
}

class _SituationDropdownButtonState extends State<SituationDropdownButton> {
  Situation? typeOfSituation;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Situation: ',
          style: context.headlineSmall.copyWith(fontSize: 14.0),
        ),
        DropdownButton(
          value: typeOfSituation,
          items: const [
            DropdownMenuItem(
              value: Situation.Natural_disaster,
              child: Text('Natural disaster'),
            ),
            DropdownMenuItem(
              value: Situation.Fire_accident,
              child: Text('Fire accident'),
            ),
            DropdownMenuItem(
              value: Situation.Accident,
              child: Text('Other accident'),
            ),
            DropdownMenuItem(
              value: Situation.Essentials_shelter,
              child: Text('Essentials/shelter aid'),
            ),
            DropdownMenuItem(
              value: Situation.Vehicle_breakdown,
              child: Text('Vehicle breakdown'),
            ),
          ],
          onChanged: (value) {
            widget.onChangeValue(value);
            setState(() {
              typeOfSituation = value;
            });
          },
        ),
      ],
    );
  }
}
