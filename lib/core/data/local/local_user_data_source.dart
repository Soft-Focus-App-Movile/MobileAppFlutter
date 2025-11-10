import 'package:shared_preferences/shared_preferences.dart';

/// Local data source for user-related data not stored in UserSession
class LocalUserDataSource {
  static const String _keyHasRelationship = "has_therapeutic_relationship";

  /// Save therapeutic relationship status
  Future<void> saveTherapeuticRelationship(bool hasRelationship) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyHasRelationship, hasRelationship);
  }

  /// Check if user has therapeutic relationship
  Future<bool> hasTherapeuticRelationship() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyHasRelationship) ?? false;
  }

  /// Clear therapeutic relationship status
  Future<void> clearTherapeuticRelationship() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyHasRelationship);
  }

  /// Clear all data
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
