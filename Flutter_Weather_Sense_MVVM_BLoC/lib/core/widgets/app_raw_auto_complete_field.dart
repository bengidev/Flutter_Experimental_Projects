import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_weather_sense_mvvm_bloc/config/config_barrel.dart';

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

  /// Provide the results of [String] type based on
  /// event when interacting [TextFormField] was done.
  final Future<void> Function(String? resultText)? onPressed;

  /// Provide the results of [String] type based on
  /// event while interacting [TextFormField] such as
  /// onChanged, onSaved, onFieldSubmitted,
  /// and onSelected when the options value was selected.
  final Future<void> Function(String? resultText)? onResult;

  const AppRawAutoCompleteField({
    super.key,
    required this.objects,
    this.focusNode,
    this.textEditingController,
    this.inputDecoration,
    this.textStyle,
    this.onPressed,
    this.onResult,
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
                  hintText: "Search your location",
                  hintStyle: $styles.textStyle.body5,
                ),
            style: textStyle ?? $styles.textStyle.body5Bold,
            textInputAction: TextInputAction.search,
            onChanged: (text) async {
              await onResult?.call(text);
            },
            onSaved: (text) async {
              if (text == null) return;
              await onResult?.call(text);
              await onPressed?.call(text);
            },
            onFieldSubmitted: (text) async {
              await onResult?.call(text);
              await onPressed?.call(text);
            },
            onEditingComplete: () async {
              focusNode.unfocus();
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
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.elementAt(index);
                  final optionString = option.toString();

                  if (optionString.isEmpty) {
                    return null;
                  }

                  return GestureDetector(
                    onTap: () async {
                      onSelected(option);
                      await onResult?.call(optionString);
                    },
                    child: ListTile(
                      title: Text(
                        _buildTitleString(objectString: optionString),
                      ),
                      subtitle: Text(
                        _buildSubTitleString(objectString: optionString),
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

  /// Build [String] from the given [objectString]
  /// and return the first index of splitted [objectString].
  String _buildTitleString({
    required String objectString,
  }) {
    final splittedStrings = objectString.split(',');
    final firstSplittedString = splittedStrings.first;
    return firstSplittedString;
  }

  /// Build [String] from the given [objectString]
  /// and return the rest of splitted [objectString],
  /// except the first index of splitted [objectString].
  String _buildSubTitleString({
    required String objectString,
  }) {
    final splittedStrings = objectString.split(', ');
    final skippedFirstStringList = splittedStrings.sublist(1);
    final mappedStringList =
        skippedFirstStringList.map<String>((e) => e).toString();
    return mappedStringList;
  }
}
