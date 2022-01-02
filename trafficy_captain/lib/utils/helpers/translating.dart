import 'package:flutter/cupertino.dart';
import 'package:trafficy_captain/generated/l10n.dart';

class Trans {
  static String localString(String word, BuildContext context) {
    if (Localizations.localeOf(context).languageCode == 'en') {
      return word;
    }
    late String newWord;
    newWord = word.replaceAll('minutes', ' ' + S.current.minutes + ' ');
    newWord = newWord.replaceAll('minute', ' ' + S.current.minute + ' ');
    newWord = newWord.replaceAll('seconds', ' ' + S.current.second + ' ');
    newWord = newWord.replaceAll('second', ' ' + S.current.seconds + ' ');
    newWord = newWord.replaceAll('hours', ' ' + S.current.hours + ' ');
    newWord = newWord.replaceAll('hour', ' ' + S.current.hour + ' ');
    newWord = newWord.replaceAll('days', ' ' + S.current.days + ' ');
    newWord = newWord.replaceAll('day', ' ' + S.current.day + ' ');
    return newWord;
  }
}
