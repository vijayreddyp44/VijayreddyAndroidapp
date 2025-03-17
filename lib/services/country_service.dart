import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/country.dart';

class CountryService {
  static const String url = 'https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json'; // Replace with actual URL

  Future<List<Country>> fetchCountries() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((country) => Country.fromJson(country)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
