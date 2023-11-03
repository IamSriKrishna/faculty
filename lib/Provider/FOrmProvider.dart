import 'package:faculty/model/Form.dart';
import 'package:flutter/material.dart';

class FormDataNotifier extends ChangeNotifier {
  List<FormModel> _formData = [];

  List<FormModel> get formData => _formData;

  void setFormData(List<FormModel> data) {
    _formData = data;
    notifyListeners();
  }
}
