import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/common/utils/toast_util.dart';
import 'package:flutter_template/data/dtos/emergency/emergency_case_dto.dart';
import 'package:flutter_template/data/models/place_model.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/presentation/emergency/bloc/set/set_emergency_case_bloc.dart';
import 'package:flutter_template/presentation/emergency/widgets/fields_select/counter.dart';
import 'package:flutter_template/presentation/emergency/widgets/images_upload/images_input.dart';
import 'package:flutter_template/presentation/emergency/widgets/fields_select/situation_dropdownbutton.dart';
import 'package:flutter_template/presentation/emergency/widgets/location_search/location_search.dart';
import 'package:flutter_template/presentation/widgets/common_alert_dialog.dart';
import 'package:flutter_template/presentation/widgets/common_rounded_button.dart';
import 'package:flutter_template/presentation/widgets/common_text_form_field.dart';

class EmergencyPostField extends StatefulWidget {
  const EmergencyPostField({super.key});

  @override
  State<EmergencyPostField> createState() => _EmergencyPostFieldState();
}

class _EmergencyPostFieldState extends State<EmergencyPostField> {
  final _detailCaseController = TextEditingController();
  final _locationController = TextEditingController();
  Situation? _typeOfSituation;
  List<File>? _images;
  PlaceModel? _choosenPlace;
  int _quantity = 1;

  @override
  void dispose() {
    super.dispose();
    _detailCaseController.dispose();
    _locationController.dispose();
  }

  void _onPostEmergencyCase() {
    if (_typeOfSituation == null ||
        _detailCaseController.text.isEmpty ||
        _choosenPlace == null) {
      ToastUtil.showError(
        context,
        text: LocaleKeys.validator_field_required.tr(),
      );
      return;
    }

    BlocProvider.of<SetEmergencyCaseBloc>(context).add(
      PostNewEmergencyCaseEvent(
        EmergencyCaseDTO(
          latitude: _choosenPlace!.coordinates!['lat']!,
          longitude: _choosenPlace!.coordinates!['lng']!,
          location: _choosenPlace!.description!,
          emergencyId: Situation.values.indexOf(_typeOfSituation!) + 1,
          quantity: _quantity,
          description: _detailCaseController.text,
          image: _images,
        ),
      ),
    );
  }

  void _showSearchScreen() async {
    _choosenPlace = await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const LocationSearchPage()),
    );
    if (_choosenPlace == null) return;
    _locationController.text = _choosenPlace!.description;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        form(context),
        const SizedBox(height: 16.0),
        BlocConsumer<SetEmergencyCaseBloc, SetEmergencyCaseState>(
          listener: (context, state) async {
            if (state.isSuccess) {
              await showDialog(
                context: context,
                builder: (context) => CommonAlertDialog(
                  title: 'Post uploaded',
                  content:
                      'Your support request at ${_choosenPlace!.description} has been posted successfully!',
                ),
              );
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            } else {
              if (state.errorMessage.isNotEmpty) {
                ToastUtil.showError(
                  context,
                  text: state.errorMessage,
                );
              }
            }
          },
          buildWhen: (previous, current) =>
              previous.isLoading != current.isLoading,
          builder: (context, state) {
            return CommonRoundedButton(
              onPressed: _onPostEmergencyCase,
              content: 'Post',
              isLoading: state.isLoading,
            );
          },
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget form(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            'Dinh Bao Chau Thi',
            style: context.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8.0),
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
        Text(
          'Location: ',
          style: context.headlineSmall.copyWith(fontSize: 14.0),
        ),
        CommonTextFormField(
          borderColor: context.themeConfig.disabledColor,
          hintText: 'Search for your location',
          suffixIcon: Icons.search,
          onTap: _showSearchScreen,
          onTapSuffixIcon: _showSearchScreen,
          textController: _locationController,
        ),
        SituationDropdownButton(
          onChangeValue: (value) {
            _typeOfSituation = value;
          },
        ),
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
        ImageInputPage(
          getImages: (value) {
            _images = value;
          },
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: Text(
                'Number of support personnel needed: ',
                style: context.headlineSmall.copyWith(fontSize: 14.0),
              ),
            ),
            CustomCounter(
              onChangedValue: (value) {
                _quantity = value;
              },
            ),
          ],
        ),
      ],
    );
  }
}
