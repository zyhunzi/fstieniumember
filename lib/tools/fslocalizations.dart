import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FSLocalizations{
  FSLocalizations(this.locale);
  final Locale locale;
  static FSLocalizations of(BuildContext context) {
    return Localizations.of<FSLocalizations>(context, FSLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'TieNiuHotel',
    },
    'zh': {
      'appTitle': '铁牛大酒店',
    },
  };

  String get appTitle {
    print(locale.languageCode);
    return _localizedValues[locale.languageCode]['appTitle'];
  }
}

class FSLocalizationsDelegate extends LocalizationsDelegate<FSLocalizations> {
  const FSLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<FSLocalizations> load(Locale locale) {
    return new SynchronousFuture<FSLocalizations>(new FSLocalizations(locale));
  }

  @override
  bool shouldReload(FSLocalizationsDelegate old) => false;

  static FSLocalizationsDelegate delegate = const FSLocalizationsDelegate();
}