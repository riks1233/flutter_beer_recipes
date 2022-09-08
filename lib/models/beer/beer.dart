import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'beer.g.dart';

// Using variable names just like in API (snake_case), because it was suggested
// here: https://docs.flutter.dev/development/data-and-backend/json
//
// "It’s best if both server and client follow the same naming strategy."

// ignore_for_file: non_constant_identifier_names

@JsonSerializable(explicitToJson: true)
class Beer extends Equatable {
    const Beer({
        this.id,
        this.name,
        this.tagline,
        this.first_brewed,
        this.description,
        this.image_url,
        this.abv,
        this.ibu,
        this.target_fg,
        this.target_og,
        this.ebc,
        this.srm,
        this.ph,
        this.attenuation_level,
        this.volume,
        this.boil_volume,
        this.method,
        this.ingredients,
        this.food_pairing,
        this.brewers_tips,
        this.contributed_by,
    });

    final int? id;
    final String? name;
    final String? tagline;
    final String? first_brewed;
    final String? description;
    final String? image_url;
    final double? abv;
    final double? ibu;
    final double? target_fg;
    final double? target_og;
    final double? ebc;
    final double? srm;
    final double? ph;
    final double? attenuation_level;
    final Volume? volume;
    final Volume? boil_volume;
    final Method? method;
    final Ingredients? ingredients;
    final List<String>? food_pairing;
    final String? brewers_tips;
    final String? contributed_by;

    factory Beer.fromJson(Map<String, dynamic> json) => _$BeerFromJson(json);
    Map<String, dynamic> toJson() => _$BeerToJson(this);

    @override
    List<Object?> get props => [
      id,
      name,
      tagline,
      first_brewed,
      description,
      image_url,
      abv,
      ibu,
      target_fg,
      target_og,
      ebc,
      srm,
      ph,
      attenuation_level,
      volume,
      boil_volume,
      method,
      ingredients,
      food_pairing,
      brewers_tips,
      contributed_by
    ];

}

@JsonSerializable(explicitToJson: true)
class Volume {
    Volume({
        this.value,
        this.unit,
    });

    final double? value;
    final String? unit;

    factory Volume.fromJson(Map<String, dynamic> json) => _$VolumeFromJson(json);
    Map<String, dynamic> toJson() => _$VolumeToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Ingredients {
    Ingredients({
        this.malt,
        this.hops,
        this.yeast,
    });

    final List<Malt>? malt;
    final List<Hop>? hops;
    final String? yeast;

    factory Ingredients.fromJson(Map<String, dynamic> json) => _$IngredientsFromJson(json);
    Map<String, dynamic> toJson() => _$IngredientsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Hop {
    Hop({
        this.name,
        this.amount,
        this.add,
        this.attribute,
    });

    final String? name;
    final Volume? amount;
    final String? add;
    final String? attribute;

    factory Hop.fromJson(Map<String, dynamic> json) => _$HopFromJson(json);
    Map<String, dynamic> toJson() => _$HopToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Malt {
    Malt({
        this.name,
        this.amount,
    });

    final String? name;
    final Volume? amount;

    factory Malt.fromJson(Map<String, dynamic> json) => _$MaltFromJson(json);
    Map<String, dynamic> toJson() => _$MaltToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Method {
    Method({
        this.mash_temp,
        this.fermentation,
        this.twist,
    });

    final List<MashTemp>? mash_temp;
    final Fermentation? fermentation;
    final String? twist;

    factory Method.fromJson(Map<String, dynamic> json) => _$MethodFromJson(json);
    Map<String, dynamic> toJson() => _$MethodToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Fermentation {
    Fermentation({
        this.temp,
    });

    final Volume? temp;

    factory Fermentation.fromJson(Map<String, dynamic> json) => _$FermentationFromJson(json);
    Map<String, dynamic> toJson() => _$FermentationToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MashTemp {
    MashTemp({
        this.temp,
        this.duration,
    });

    final Volume? temp;
    final double? duration;

    factory MashTemp.fromJson(Map<String, dynamic> json) => _$MashTempFromJson(json);
    Map<String, dynamic> toJson() => _$MashTempToJson(this);
}
