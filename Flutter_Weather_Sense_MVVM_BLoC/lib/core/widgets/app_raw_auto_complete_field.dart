import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';
import 'package:flutter_weather_sense_mvvm_bloc/core/core_barrel.dart';

class AppRawAutoCompleteField extends HookWidget {
  /// [Object]s that will be used for displaying options to be selected.
  final List<Object> objects;

  /// Control the focus of [TextFormField]
  /// when interact with [AppRawAutoCompleteField].
  final FocusNode? focusNode;

  /// Control the activities of [TextFormField]
  /// inside the [AppRawAutoCompleteField].
  final TextEditingController? textEditingController;

  /// Decorate [TextFormField] elements from [InputDecoration] parameters.
  final InputDecoration? inputDecoration;

  /// Change the [TextStyle] of [TextFormField].
  final TextStyle? textStyle;

  /// Show the hint text inside the [TextFormField].
  final String? hintText;

  /// Provide the results of [resultText] and [index]
  /// based on event when interacting [TextFormField] was done.
  final Future<void> Function(String resultText, int index)? onButtonPressed;

  /// Provide the results of of [resultText] and [index]
  /// based on event while interacting [TextFormField] such as
  /// onChanged, onSaved, onFieldSubmitted,
  /// and onSelected when the options value was selected.
  final Future<void> Function(String resultText, int index)? onTextChanged;

  /// Provide the results' [index]
  /// based on event when interacting [TextFormField] was done.
  final Future<void> Function(int index)? onOptionPressed;

  const AppRawAutoCompleteField({
    super.key,
    required this.objects,
    this.focusNode,
    this.textEditingController,
    this.inputDecoration,
    this.textStyle,
    this.hintText,
    this.onButtonPressed,
    this.onTextChanged,
    this.onOptionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<Object>(
      key: key,
      focusNode: focusNode,
      textEditingController: textEditingController,
      optionsBuilder: (textEditingValue) => objects,
      displayStringForOption: (option) => option.toString(),
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return Padding(
          padding: EdgeInsets.only(
            left: $styles.insets.sm,
            right: $styles.insets.sm,
          ),
          child: TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            decoration: inputDecoration ??
                InputDecoration(
                  contentPadding: EdgeInsets.all($styles.insets.xs),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular($styles.insets.xs),
                    borderSide: BorderSide(color: $styles.colors.offBlack),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular($styles.insets.xs),
                    borderSide: BorderSide(color: $styles.colors.offBlack),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular($styles.insets.xs),
                    borderSide: BorderSide(color: $styles.colors.error),
                  ),
                  prefixIcon: const Icon(Icons.search_rounded),
                  prefixIconColor: $styles.colors.offBlack,
                  hintText: hintText ?? "Search your location",
                  hintStyle: $styles.textStyle.body5,
                ),
            style: textStyle ?? $styles.textStyle.body5Bold,
            textInputAction: TextInputAction.search,
            onChanged: (text) async {
              await onTextChanged?.call(text, 0);
            },
            onSaved: (text) async {
              if (text == null) return;
              await onButtonPressed?.call(text, 0);
            },
            onFieldSubmitted: (text) async {
              await onButtonPressed?.call(text, 0);
              // focusNode.unfocus();
            },
            onEditingComplete: () async {
              await onButtonPressed?.call(textEditingController.text, 0);
              // focusNode.unfocus();
            },
            onTapOutside: (event) {
              focusNode.unfocus();
            },
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return TopCenter(
          child: SizedBox(
            width: context.widthPct(.9),
            height: context.heightPct(.2),
            child: Material(
              elevation: 10,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular($styles.corners.xs),
                  bottomRight: Radius.circular($styles.corners.xs),
                ),
              ),
              child: ListView.builder(
                padding: EdgeInsets.all($styles.insets.xxs),
                shrinkWrap: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                itemCount: objects.length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.elementAt(index);
                  final optionString = option.toString();

                  if (optionString.isEmpty) {
                    return null;
                  }

                  return GestureDetector(
                    onTap: () async {
                      await onOptionPressed?.call(index);
                      onSelected(option);
                      focusNode?.unfocus();
                    },
                    child: ListTile(
                      title: Text(
                        LocationDetailHelper.buildLocationTitle(
                          objectString: optionString,
                        ),
                      ),
                      subtitle: Text(
                        LocationDetailHelper.buildLocationSubTitle(
                          objectString: optionString,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
