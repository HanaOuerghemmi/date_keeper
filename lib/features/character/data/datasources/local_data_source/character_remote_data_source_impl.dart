





import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:date_keeper/core/constants/app_constant.dart';
import 'package:date_keeper/core/error/execption.dart';
import 'package:date_keeper/features/character/data/datasources/local_data_source/character_remote_data_source.dart';
import 'package:date_keeper/features/character/data/models/character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final SharedPreferences sharedPreferences;

  CharacterLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheCharacters(List<CharacterModel> characterModels) {
    List characterModelsToJson = characterModels
        .map<Map<String, dynamic>>((characterModel) => characterModel.toJson())
        .toList();
    sharedPreferences.setString(AppConstant.cachedCharcters, json.encode(characterModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<CharacterModel>> getCachedCharacters() {
    final jsonString = sharedPreferences.getString(AppConstant.cachedCharcters);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<CharacterModel> jsonToCharacterModels = decodeJsonData
          .map<CharacterModel>((jsonCharacterModel) => CharacterModel.fromJson(jsonCharacterModel))
          .toList();
      return Future.value(jsonToCharacterModels);
    } else {
      throw EmptyCacheException();
    }
  }
}