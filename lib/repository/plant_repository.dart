import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:nature_log_flutter/config/app_config.dart';

class PlantRepository {
  final String apiUrlPlantNet = "https://my-api.plantnet.org/v2/identify/";
  final String project = "all";
  late final String finalUrlPlantNet = apiUrlPlantNet + project + "?api-key="+ AppConfig.plantNetApiKey;

  final String apiUrlINaturalist = "https://api.inaturalist.org/v1/search";

  Future<String> identifyPlant(File imageFile) async {
    var request = http.MultipartRequest('POST', Uri.parse(finalUrlPlantNet));
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

  Future<List<Map<String, String>>> searchPlant(String query) async{
    var response = await http.get(Uri.parse('$apiUrlINaturalist?q=$query&sources=taxa&per_page=5'));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> results = jsonResponse['results'] ?? [];
      List<Map<String, String>> plantList = [];

      for (var result in results.take(5)) {
        String name = result['name'] ?? 'Inconnu';
        String imageUrl = result['default_photo']?['square_url'] ?? '';

        plantList.add({
          'name': name,
          'url': imageUrl,
        });
      }

      return plantList;

    } else {
      throw Exception('Failed to search plant. Status code: ${response.statusCode}');
    }
  }
}
