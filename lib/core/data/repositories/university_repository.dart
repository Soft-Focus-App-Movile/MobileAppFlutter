import '../../domain/models/university_info.dart';
import '../services/university_service.dart';

/// Repository for university-related operations
class UniversityRepository {
  final UniversityService _service;

  UniversityRepository({UniversityService? service})
      : _service = service ?? UniversityService();

  /// Search universities by name
  /// Returns empty list if query is less than 2 characters
  Future<List<UniversityInfo>> searchUniversities(String query) async {
    try {
      if (query.length < 2) {
        return [];
      }

      final universities = await _service.searchUniversities(name: query);
      return universities.map((dto) {
        return UniversityInfo(
          name: dto.name,
          region: dto.stateProvince ?? _extractRegionFromName(dto.name),
        );
      }).toList();
    } catch (e) {
      // Return empty list on error (fail silently for autocomplete)
      return [];
    }
  }

  /// Extract region from university name using keyword matching
  String _extractRegionFromName(String name) {
    const regions = {
      'Lima': [
        'Lima',
        'San Marcos',
        'Católica',
        'Pacífico',
        'Cayetano'
      ],
      'Arequipa': ['Arequipa', 'Santa María', 'San Agustín de Arequipa'],
      'Cusco': ['Cusco', 'Andina del Cusco'],
      'Trujillo': ['Trujillo', 'Privada Antenor Orrego', 'César Vallejo'],
      'Piura': ['Piura'],
      'Ica': ['Ica', 'San Luis Gonzaga'],
      'Huancayo': ['Centro del Perú', 'Continental'],
      'Chiclayo': ['Chiclayo', 'Pedro Ruiz Gallo', 'Señor de Sipán'],
      'Tacna': ['Tacna'],
      'Puno': ['Puno', 'Altiplano'],
      'Lambayeque': ['Lambayeque'],
      'Cajamarca': ['Cajamarca'],
      'Ayacucho': ['Ayacucho', 'San Cristóbal de Huamanga'],
      'Huánuco': ['Huánuco', 'Hermilio Valdizán'],
      'Junín': ['Junín'],
      'Loreto': ['Loreto', 'Amazonía Peruana'],
      'Ucayali': ['Ucayali'],
      'San Martín': ['San Martín'],
      'Ancash': ['Ancash', 'Santiago Antúnez de Mayolo'],
      'Apurímac': ['Apurímac', 'Micaela Bastidas'],
      'Huancavelica': ['Huancavelica'],
      'Madre de Dios': ['Madre de Dios'],
      'Moquegua': ['Moquegua'],
      'Pasco': ['Pasco', 'Daniel Alcides Carrión'],
      'Tumbes': ['Tumbes'],
      'Amazonas': ['Amazonas'],
    };

    for (final entry in regions.entries) {
      final region = entry.key;
      final keywords = entry.value;

      for (final keyword in keywords) {
        if (name.toLowerCase().contains(keyword.toLowerCase())) {
          return region;
        }
      }
    }

    return 'Lima'; // Default region
  }
}
