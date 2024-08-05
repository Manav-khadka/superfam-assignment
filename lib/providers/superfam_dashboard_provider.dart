import 'package:flutter/material.dart';
import 'package:superfam_assignment/database/key_value_repository.dart';
import 'package:superfam_assignment/models/key_value_model.dart';

class SuperfamDashboardProvider extends ChangeNotifier {
  final KeyValueRepository keyValueRepository = KeyValueRepository();
  final TextEditingController _keyController = TextEditingController();
  TextEditingController get getKeyController => _keyController;
  
  final TextEditingController _valueController = TextEditingController();
  TextEditingController get getValueController => _valueController;

  bool isNoKeyValue = true;
  bool get getIsNoKeyValue => isNoKeyValue;

  List<KeyValue> keyValueList = [];
  List<KeyValue> get getKeyValueList => keyValueList;

  SuperfamDashboardProvider() {
    getAllKeyValues();
  }

  void getAllKeyValues() async {
    keyValueList = await keyValueRepository.getAllKeyValues();
    if (keyValueList.isEmpty) {
      setIsNoKeyValue(true);
    } else {
      setAllKeyValues(keyValueList);
      setIsNoKeyValue(false);
    }
    notifyListeners();
  }

  void addKeyValue(KeyValue keyValue) {

    keyValueRepository.insert(keyValue);
    getAllKeyValues();
  }

  void deleteKeyValue(int id) {
    keyValueRepository.delete(id);
    getAllKeyValues();
  }

  void updateKeyValue(KeyValue keyValue) {
    keyValueRepository.update(keyValue);
    getAllKeyValues();
  }

  void setAllKeyValues(List<KeyValue> keyValueList) {
    this.keyValueList = keyValueList;
    notifyListeners();
  }

  void setIsNoKeyValue(bool isNoKeyValue) {
    this.isNoKeyValue = isNoKeyValue;
    notifyListeners();
  }
}
