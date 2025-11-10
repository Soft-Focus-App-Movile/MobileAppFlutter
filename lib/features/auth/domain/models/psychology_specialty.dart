/// Psychology specialties matching backend enum.
/// Each specialty has a display name (for UI), backend name (for registration), and integer value (for verification).
enum PsychologySpecialty {
  CLINICA('Clínica', 'Clinica', 0),
  EDUCATIVA('Educativa', 'Educativa', 1),
  ORGANIZACIONAL('Organizacional', 'Organizacional', 2),
  SOCIAL('Social', 'Social', 3),
  DEPORTIVA('Deportiva', 'Deportiva', 4),
  FORENSE('Forense', 'Forense', 5),
  NEUROPSICOLOGIA('Neuropsicología', 'Neuropsicologia', 6),
  SALUD('Salud', 'Salud', 7),
  EMERGENCIAS('Emergencias', 'Emergencias', 8),
  INFANTIL('Infantil', 'Infantil', 9),
  ADOLESCENTES('Adolescentes', 'Adolescentes', 10),
  PAREJAS('Parejas', 'Parejas', 11),
  FAMILIA('Familia', 'Familia', 12),
  ADICCIONES('Adicciones', 'Adicciones', 13),
  TRAUMA('Trauma', 'Trauma', 14),
  ANSIEDAD('Ansiedad', 'Ansiedad', 15),
  DEPRESION('Depresión', 'Depresion', 16);

  final String displayName;
  final String backendName;
  final int value;

  const PsychologySpecialty(this.displayName, this.backendName, this.value);

  /// Get specialty by display name (case-insensitive)
  static PsychologySpecialty? fromDisplayName(String displayName) {
    try {
      return PsychologySpecialty.values.firstWhere(
        (specialty) => specialty.displayName.toLowerCase() == displayName.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  /// Get all display names for UI
  static List<String> getAllDisplayNames() {
    return PsychologySpecialty.values.map((e) => e.displayName).toList();
  }
}
