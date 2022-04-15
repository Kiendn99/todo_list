import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';

mixin ValidateFieldController on ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  initTextFieldController({String? title, String? description, DateTime? dateTime}) {
    titleController = TextEditingController(text: title);
    descriptionController = TextEditingController(text: description);
    time = dateTime;
  }

  bool isEdit = false;
  bool _isValid = true;
  DateTime? time;

  String? validateTitle(String value) {
    if (value.trim().isEmpty) return "Do not leave the title blank";

    return null;
  }

  pickDateTime() async {
    time = await DatePicker.showDateTimePicker(Get.context!, showTitleActions: true, minTime: DateTime.now(), maxTime: DateTime(2025, 6, 7), onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      print('confirm $date');
    }, currentTime: DateTime.now(), locale: LocaleType.vi);
    notifyListeners();
  }

  String? validateDescription(String value) {
    if (value.trim().isEmpty) {
      return "Do not leave the description blank";
    }
    return null;
  }

  bool get checkInvalidFormUpdateTask {
    _isValid = formKey.currentState!.validate();
    if (_isValid && isEdit) {
      FocusManager.instance.primaryFocus?.unfocus();
      isEdit = !isEdit;
      return true;
    }
    if (isEdit == false) isEdit = !isEdit;

    return false;
  }

  bool get checkInvalidFormAddTask {
    FocusManager.instance.primaryFocus?.unfocus();
    return formKey.currentState!.validate() && time != null;
  }

  disposeTextFieldController() {
    titleController.dispose();
    descriptionController.dispose();
    time == null;
  }
}
