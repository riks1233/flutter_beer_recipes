// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Beer _$BeerFromJson(Map<String, dynamic> json) => Beer(
      id: json['id'] as int?,
      name: json['name'] as String?,
      tagline: json['tagline'] as String?,
      first_brewed: json['first_brewed'] as String?,
      description: json['description'] as String?,
      image_url: json['image_url'] as String?,
      abv: (json['abv'] as num?)?.toDouble(),
      ibu: (json['ibu'] as num?)?.toDouble(),
      target_fg: (json['target_fg'] as num?)?.toDouble(),
      target_og: (json['target_og'] as num?)?.toDouble(),
      ebc: (json['ebc'] as num?)?.toDouble(),
      srm: (json['srm'] as num?)?.toDouble(),
      ph: (json['ph'] as num?)?.toDouble(),
      attenuation_level: (json['attenuation_level'] as num?)?.toDouble(),
      volume: json['volume'] == null
          ? null
          : Volume.fromJson(json['volume'] as Map<String, dynamic>),
      boil_volume: json['boil_volume'] == null
          ? null
          : Volume.fromJson(json['boil_volume'] as Map<String, dynamic>),
      method: json['method'] == null
          ? null
          : Method.fromJson(json['method'] as Map<String, dynamic>),
      ingredients: json['ingredients'] == null
          ? null
          : Ingredients.fromJson(json['ingredients'] as Map<String, dynamic>),
      food_pairing: (json['food_pairing'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      brewers_tips: json['brewers_tips'] as String?,
      contributed_by: json['contributed_by'] as String?,
    );

Map<String, dynamic> _$BeerToJson(Beer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tagline': instance.tagline,
      'first_brewed': instance.first_brewed,
      'description': instance.description,
      'image_url': instance.image_url,
      'abv': instance.abv,
      'ibu': instance.ibu,
      'target_fg': instance.target_fg,
      'target_og': instance.target_og,
      'ebc': instance.ebc,
      'srm': instance.srm,
      'ph': instance.ph,
      'attenuation_level': instance.attenuation_level,
      'volume': instance.volume?.toJson(),
      'boil_volume': instance.boil_volume?.toJson(),
      'method': instance.method?.toJson(),
      'ingredients': instance.ingredients?.toJson(),
      'food_pairing': instance.food_pairing,
      'brewers_tips': instance.brewers_tips,
      'contributed_by': instance.contributed_by,
    };

Volume _$VolumeFromJson(Map<String, dynamic> json) => Volume(
      value: (json['value'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$VolumeToJson(Volume instance) => <String, dynamic>{
      'value': instance.value,
      'unit': instance.unit,
    };

Ingredients _$IngredientsFromJson(Map<String, dynamic> json) => Ingredients(
      malt: (json['malt'] as List<dynamic>?)
          ?.map((e) => Malt.fromJson(e as Map<String, dynamic>))
          .toList(),
      hops: (json['hops'] as List<dynamic>?)
          ?.map((e) => Hop.fromJson(e as Map<String, dynamic>))
          .toList(),
      yeast: json['yeast'] as String?,
    );

Map<String, dynamic> _$IngredientsToJson(Ingredients instance) =>
    <String, dynamic>{
      'malt': instance.malt?.map((e) => e.toJson()).toList(),
      'hops': instance.hops?.map((e) => e.toJson()).toList(),
      'yeast': instance.yeast,
    };

Hop _$HopFromJson(Map<String, dynamic> json) => Hop(
      name: json['name'] as String?,
      amount: json['amount'] == null
          ? null
          : Volume.fromJson(json['amount'] as Map<String, dynamic>),
      add: json['add'] as String?,
      attribute: json['attribute'] as String?,
    );

Map<String, dynamic> _$HopToJson(Hop instance) => <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount?.toJson(),
      'add': instance.add,
      'attribute': instance.attribute,
    };

Malt _$MaltFromJson(Map<String, dynamic> json) => Malt(
      name: json['name'] as String?,
      amount: json['amount'] == null
          ? null
          : Volume.fromJson(json['amount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MaltToJson(Malt instance) => <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount?.toJson(),
    };

Method _$MethodFromJson(Map<String, dynamic> json) => Method(
      mash_temp: (json['mash_temp'] as List<dynamic>?)
          ?.map((e) => MashTemp.fromJson(e as Map<String, dynamic>))
          .toList(),
      fermentation: json['fermentation'] == null
          ? null
          : Fermentation.fromJson(json['fermentation'] as Map<String, dynamic>),
      twist: json['twist'] as String?,
    );

Map<String, dynamic> _$MethodToJson(Method instance) => <String, dynamic>{
      'mash_temp': instance.mash_temp?.map((e) => e.toJson()).toList(),
      'fermentation': instance.fermentation?.toJson(),
      'twist': instance.twist,
    };

Fermentation _$FermentationFromJson(Map<String, dynamic> json) => Fermentation(
      temp: json['temp'] == null
          ? null
          : Volume.fromJson(json['temp'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FermentationToJson(Fermentation instance) =>
    <String, dynamic>{
      'temp': instance.temp?.toJson(),
    };

MashTemp _$MashTempFromJson(Map<String, dynamic> json) => MashTemp(
      temp: json['temp'] == null
          ? null
          : Volume.fromJson(json['temp'] as Map<String, dynamic>),
      duration: (json['duration'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MashTempToJson(MashTemp instance) => <String, dynamic>{
      'temp': instance.temp?.toJson(),
      'duration': instance.duration,
    };
