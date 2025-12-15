import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:nature_log_flutter/config/app_config.dart';

class PlantRepository {
  final String apiUrl = "https://my-api.plantnet.org/v2/identify/";
  final String project = "all";
  late final String finalUrl = apiUrl + project + "?api-key="+ AppConfig.plantNetApiKey;

  Future<String> identifyPlant(File imageFile) async {
    var request = http.MultipartRequest('POST', Uri.parse(finalUrl));
    request.files.add(await http.MultipartFile.fromPath('images', imageFile.path));
    request.fields['organs'] = 'auto';

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

      List<dynamic> results = jsonResponse['results'] ?? [];
      if (results.isEmpty) {
        return "Aucune plante reconnue";
      }

      results.sort((a, b) => (b['score'] as num).compareTo(a['score'] as num));
      var bestResult = results.first;

      return bestResult['species']['scientificNameWithoutAuthor'] ?? "Inconnu";
    } else {
      throw Exception('Failed to identify plant. Status code: ${response.statusCode}');
    }
  }
}
