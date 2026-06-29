import 'package:shared_preferences/shared_preferences.dart';

import '../data/content.dart';

class JourneyProgressStore {
  JourneyProgressStore._();

  static const String _currentStepIndexKey = 'journey_current_step_index';
  static const String _legacySituationIndexKey = 'journey_situation_index';

  static Future<int?> loadCurrentStepIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final currentStepIndex = prefs.getInt(_currentStepIndexKey);
    if (currentStepIndex != null) return currentStepIndex;

    final legacySituationIndex = prefs.getInt(_legacySituationIndexKey);
    if (legacySituationIndex == null) return null;

    final migratedStepIndex = currentStepIndexForOnboarding(legacySituationIndex);
    await prefs.setInt(_currentStepIndexKey, migratedStepIndex);
    return migratedStepIndex;
  }

  static Future<void> saveCurrentStepIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_currentStepIndexKey, index);
  }

  static Future<void> saveSituationIndex(int index) {
    return saveCurrentStepIndex(currentStepIndexForOnboarding(index));
  }
}
