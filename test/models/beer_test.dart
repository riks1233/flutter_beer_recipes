// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';

import 'package:entain_beer_task_richardas/models/beer/beer.dart';
import 'package:flutter_test/flutter_test.dart';

List<dynamic> _getBeersListJson() {
  final beersJsonString =
      File('test/test_resources/sample_beers.json').readAsStringSync();
  return jsonDecode(beersJsonString);
}

void main() {
  group('Beer', () {
    test('converts properly from JSON to model', () {
      final beersJsonString =
          File('test/test_resources/sample_beers.json').readAsStringSync();
      List<dynamic> beersListJson = jsonDecode(beersJsonString);
      expect(
          Beer.fromJson(beersListJson[0]),
          Beer(
              id: 1,
              name: 'Walter',
              ingredients: Ingredients(malt: const <Malt>[
                Malt(
                    name: 'Caramalt',
                    amount: Volume(value: 2, unit: 'kilograms'))
              ], yeast: 'Wyeast')));
    });

    test('supports value comparison', () {
      List<dynamic> beersListJson = _getBeersListJson();
      expect(Beer.fromJson(beersListJson[0]), Beer.fromJson(beersListJson[0]));
      expect(Beer.fromJson(beersListJson[0]), Beer.fromJson(beersListJson[0]));
      expect(Beer(id: 1, name: 'Walter'), Beer(id: 1, name: 'Walter'));
      expect(Beer(id: 1, name: 'Walter'),
          isNot(Beer(id: 2, name: 'I am Bobby Fischer tonight')));
      expect(Beer.fromJson(beersListJson[0]),
          isNot(Beer.fromJson(beersListJson[1])));
    });
  });
}
