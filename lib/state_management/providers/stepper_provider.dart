import 'package:flutter/cupertino.dart';

class StepperProvider extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _isFirstStepDone = false;
  bool _isOnFirstStep = true;

  bool get isFirstStepDone => _isFirstStepDone;

  set isFirstStepDone(bool value) {
    _isFirstStepDone = value;
    notifyListeners();
  }

  bool get isOnFirstStep => _isOnFirstStep;

  set isOnFirstStep(bool value) {
    _isOnFirstStep = value;
    notifyListeners();
  }
}
