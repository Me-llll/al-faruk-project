import 'package:flutter/material.dart';

class AfaanOromoMaterialLocalizations extends DefaultMaterialLocalizations {
  AfaanOromoMaterialLocalizations();

  @override
  String get backButtonTooltip => 'Duubi Deebi\'i';
  
  @override
  String get cancelButtonLabel => 'Haaki';
  
  @override
  String get closeButtonLabel => 'Cufi';
  
  @override
  String get continueButtonLabel => 'Itti Fufi';
  
  @override
  String get copyButtonLabel => 'Raabsifadhaa';
  
  @override
  String get cutButtonLabel => 'Muressi';
  
  @override
  String get deleteButtonTooltip => 'Haassi';
  
  @override
  String get pasteButtonLabel => 'Naashi';
  
  @override
  String get selectAllButtonLabel => 'Hundaa Filadhu';

  // Add more translations as needed
}

class AfaanOromoLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const AfaanOromoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'om';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    return AfaanOromoMaterialLocalizations();
  }

  @override
  bool shouldReload(AfaanOromoLocalizationsDelegate old) => false;
}