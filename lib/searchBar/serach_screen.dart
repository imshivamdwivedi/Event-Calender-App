import 'package:calender/searchBar/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 200, horizontal: 50),
          padding: EdgeInsets.all(20),
          child: TypeAheadField<Category?>(
            debounceDuration: Duration(microseconds: 500),
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Serach User name'),
            ),
            suggestionsCallback: CategoryAPI.getUserSuggestion,
            itemBuilder: (context, Category? suggestions) {
              final category = suggestions!;
              return ListTile(
                title: Text(category.name),
              );
            },
            noItemsFoundBuilder: (context) => Container(
              height: 100,
              child: Center(
                child: Text('No user Found'),
              ),
            ),
            onSuggestionSelected: (Category? suggestions) {
              final category = suggestions;

              Text(category!.name);
            },
          ),
        ),
      ),
    );
  }
}
