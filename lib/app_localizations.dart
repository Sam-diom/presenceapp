import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Define your localized strings here
  static final Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'signInTitle': 'Sign in',
      'validEmailMessage': 'Please enter a valid email',
      'enterEmailHint': 'Enter your email',
      'enterPasswordHint': 'Enter your password',
      'signInButton': 'Sign in',
      'notRegisteredYet': 'Not registered yet?',
      'createAccount': 'Create an account',
    },
    'fr': {
      'signInTitle': 'Se connecter',
      'validEmailMessage': 'Veuillez entrer une adresse e-mail valide',
      'enterEmailHint': 'Entrez votre e-mail',
      'enterPasswordHint': 'Entrez votre mot de passe',
      'signInButton': 'Se connecter',
      'notRegisteredYet': 'Pas encore inscrit ?',
      'createAccount': 'Créer un compte',
    },
  };

  String translate(String key) {
    return _localizedStrings[locale.languageCode]![key] ?? '';
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['fr', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
