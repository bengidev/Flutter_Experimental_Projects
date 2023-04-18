import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';

class AppRawAutoCompleteField extends HookWidget {
  /// [Object]s that will be used for displaying options to be selected.
  final List<Object> objects;

  /// Decorate [TextFormField] elements from [InputDecoration] parameters.
  final InputDecoration? inputDecoration;

  /// Change the [TextStyle] of [TextFormField].
  final TextStyle? textStyle;

  /// Provide the results of [String] type based on
  /// event while interacting [TextFormField] like
  /// onChanged, onSaved, onFieldSubmitted,
  /// and onSelected when the options value was selected.
  final void Function(String? resultText)? onResult;

  const AppRawAutoCompleteField({
    super.key,
    required this.objects,
    this.inputDecoration,
    this.textStyle,
    this.onResult,
  });

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<Object>(
      optionsBuilder: (textEditingValue) {
        return objects.where((Object object) {
          return object
              .toString()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      displayStringForOption: (option) =>
          _displayStringForOptions(object: option),
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
                  hintText: "Search your location",
                  hintStyle: $styles.textStyle.body5,
                ),
            style: textStyle ?? $styles.textStyle.body5Bold,
            textInputAction: TextInputAction.search,
            onChanged: (text) {
              onResult?.call(text);
            },
            onSaved: (text) {
              if (text == null) return;
              onResult?.call(text);
            },
            onFieldSubmitted: (text) {
              onResult?.call(text);
              onFieldSubmitted.call();
            },
            onEditingComplete: () {
              focusNode.unfocus();
            },
            onTapOutside: (event) {
              focusNode.unfocus();
            },
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Padding(
          padding: EdgeInsets.only(
            left: $styles.insets.sm,
            right: $styles.insets.sm,
          ),
          child: TopCenter(
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
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final Object option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                      onResult?.call(option.toString());
                    },
                    child: ListTile(
                      title: Text(_displayStringForOptions(object: option)),
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

  /// Display the [String] of each [Object] value.
  String _displayStringForOptions({required Object object}) =>
      object.toString();
}
