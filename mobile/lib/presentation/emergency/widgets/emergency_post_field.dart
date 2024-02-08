import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/presentation/emergency/widgets/images_input.dart';
import 'package:flutter_template/presentation/widgets/common_rounded_button.dart';

class EmergencyPostField extends StatefulWidget {
  const EmergencyPostField({super.key});

  @override
  State<EmergencyPostField> createState() => _EmergencyPostFieldState();
}

class _EmergencyPostFieldState extends State<EmergencyPostField> {
  final _detailCaseController = TextEditingController();
  final _notesController = TextEditingController();
  late final List<File>? images;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _detailCaseController.dispose();
    _notesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            'Nguyen Van A',
            style: context.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8.0),
        RichText(
          text: TextSpan(
            text: 'Address: ',
            style: context.headlineSmall.copyWith(fontSize: 14.0),
            children: <TextSpan>[
              TextSpan(
                text: '108 Bach Dang, Hai Chau, Da Nang',
                style: context.bodyMedium,
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            text: 'Phone number: ',
            style: context.headlineSmall.copyWith(fontSize: 14.0),
            children: <TextSpan>[
              TextSpan(
                text: '0909060612',
                style: context.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: double.infinity,
          child: Text(
            'What\'s your emergency situation?',
            style: context.headlineSmall.copyWith(fontSize: 14.0),
          ),
        ),
        TextField(
          controller: _detailCaseController,
          autocorrect: false,
          enableSuggestions: false,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          minLines: 3,
          maxLines: 6,
          maxLength: 500,
          keyboardType: TextInputType.multiline,
        ),
        ImageInput(),
        const SizedBox(height: 16.0),
        SizedBox(
          width: double.infinity,
          child: Text(
            'Notes: ',
            style: context.headlineSmall.copyWith(fontSize: 14.0),
          ),
        ),
        TextField(
          autocorrect: false,
          enableSuggestions: false,
          controller: _notesController,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          ),
          minLines: 3,
          maxLines: 6,
          maxLength: 500,
          keyboardType: TextInputType.multiline,
        ),
        const SizedBox(height: 16.0),
        Center(
          child: CommonRoundedButton(
            onPressed: _onPostEmergencyCase,
            content: 'Post',
            borderRadius: 16.0,
          ),
        ),
      ],
    );
  }

  void _onPostEmergencyCase() {}
}
