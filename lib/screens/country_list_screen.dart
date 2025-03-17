import 'package:flutter/material.dart';
import '../models/country.dart';
import '../services/country_service.dart';

class CountryListScreen extends StatefulWidget {
  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  late Future<List<Country>> futureCountries;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    futureCountries = CountryService().fetchCountries();
    futureCountries.catchError((error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load countries. Please try again.';
      });
    });
  }

  void retryFetch() {
    setState(() {
      isLoading = true;
      errorMessage = '';
      futureCountries = CountryService().fetchCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country List'),
      ),
      body: FutureBuilder<List<Country>>(
        future: futureCountries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(errorMessage),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: retryFetch,
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            List<Country> countries = snapshot.data!;
            return ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                Country country = countries[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(country.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Region: ${country.region}'),
                        Text('Code: ${country.code}'),
                        Text('Capital: ${country.capital}'),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
