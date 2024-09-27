import 'package:coventil/src/presentation/add_device_sheet/view_model/add_device_sheet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../common/widgets/custom_input.dart';

class AddDeviceSheetSerialNumberInput extends StatefulWidget {
  final AddDeviceSheetViewModel model;
  final TextEditingController controller;
  final GlobalKey<State<StatefulWidget>> formKey;
  final String errorText;

  const AddDeviceSheetSerialNumberInput({
    super.key,
    required this.model,
    required this.controller,
    required this.formKey,
    required this.errorText,
  });

  @override
  State<AddDeviceSheetSerialNumberInput> createState() => _AddDeviceSheetSerialNumberInputState();
}

class _AddDeviceSheetSerialNumberInputState extends State<AddDeviceSheetSerialNumberInput> {
  var maskFormatter = MaskTextInputFormatter(
    mask: '####-####-####-####',
    filter: {
      "#": RegExp(r'^[0-9]*$|^[a-zA-Z]*$'),
    },
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: CustomInput(
        hintText: 'Seri no giriniz',
        controller: widget.controller,
        inputFormatters: [maskFormatter],
        onChanged: (String value) => widget.model.onChanged(value, widget.controller),
        error: widget.model.isError,
        errorText: widget.errorText,
        validator: (value) => null,
      ),
    );
  }
}
