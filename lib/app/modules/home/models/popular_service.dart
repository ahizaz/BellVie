import 'package:bellevie/app/services/api_service.dart';

class PopularService {
  final int id;
  final String name;
  final String iconUrl;

  PopularService({
    required this.id,
    required this.name,
    required this.iconUrl,
  });

  factory PopularService.fromJson(Map<String, dynamic> json) {
    final rawIcon = (json['icon'] ?? '').toString();
    final resolvedIcon = _resolveImageUrl(rawIcon);
    final idVal = json['id'];
    final id =
        idVal is int ? idVal : int.tryParse(idVal?.toString() ?? '') ?? 0;
    return PopularService(
      id: id,
      name: (json['name'] ?? '').toString().trim(),
      iconUrl: resolvedIcon,
    );
  }

  static String _resolveImageUrl(String value) {
    if (value.trim().isEmpty) return '';
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return value;
    }
    return '${AppApiService.baseUrl}$value';
  }
}
