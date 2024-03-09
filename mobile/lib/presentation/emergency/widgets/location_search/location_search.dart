import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/common/extensions/context_extension.dart';
import 'package:flutter_template/data/repositories/place_repository.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/presentation/emergency/bloc/place_search/place_search_bloc.dart';
import 'package:flutter_template/presentation/widgets/common_text_form_field.dart';

class LocationSearchPage extends StatelessWidget {
  const LocationSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlaceSearchBloc(getIt.get<PlaceRepository>()),
      child: const LocationSearchView(),
    );
  }
}

class LocationSearchView extends StatelessWidget {
  const LocationSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: CommonTextFormField(
              borderColor: context.themeConfig.disabledColor,
              onChanged: (value) {
                context
                    .read<PlaceSearchBloc>()
                    .add(GetSuggestions(input: value));
              },
              hintText: 'Search for a location',
            ),
          ),
          BlocBuilder<PlaceSearchBloc, PlaceSearchState>(
            builder: (context, state) {
              final suggestions =
                  context.watch<PlaceSearchBloc>().state.suggestions;
              return ListView.separated(
                itemCount: state.suggestions.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(suggestions[index]);
                    },
                    child: suggestions.isEmpty
                        ? const SizedBox.shrink()
                        : ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: context.themeConfig.primaryColor,
                            ),
                            title: Text(
                              suggestions[index].description,
                              style: context.titleSmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            dense: true,
                          ),
                  );
                },
                separatorBuilder: (_, __) {
                  return const Divider(
                    thickness: 1.2,
                  );
                },
                shrinkWrap: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
