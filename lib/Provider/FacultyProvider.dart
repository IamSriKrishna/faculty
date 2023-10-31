
import 'package:faculty/model/faculty.dart';
import 'package:flutter/material.dart';

class FacultyProvider extends ChangeNotifier {
  faculty _user = faculty(
      id: '',
      name: '',
      email: '',
      password: '',
      role: '',
      classTeacher: '',
      department: '',
      dp: '',
      token: '',
  );

  faculty get user => _user;

  void setUser(String user) {
    _user = faculty.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(faculty user) {
    _user = user;
    notifyListeners();
  }

  
  void signOut() {
    _user = faculty(
      id: '',
      name: '',
      email: '',
      password: '',
      role: '',
      classTeacher: '',
      department: '',
      dp: '',
      token: '',
    );
    
    notifyListeners();
  }
}