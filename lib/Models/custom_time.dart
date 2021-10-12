import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomTime {
  static String displayTimeAgoFromTimestamp(
      String dateString, BuildContext context,
      {bool numericDates = true}) {
    DateTime date = DateTime.parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(date);
    print("THe difference is ");
    print(difference);
    if ((difference.inDays / 365).floor() >= 2) {
      return context.locale == Locale("am")
          ? 'ከ ${(difference.inDays / 365).floor()} ዓመታት በፊት'
          : '${(difference.inDays / 365).floor()} years ago';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return context.locale == Locale("am")
          ? (numericDates)
              ? 'ከ 1 ዓመት በፊት'
              : 'ባልፈው ዓመት'
          : (numericDates)
              ? '1 year ago'
              : 'A year ago';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return context.locale == Locale("am")
          ? 'ከ ${(difference.inDays / 30).floor()} ወራት በፊት'
          : '${(difference.inDays / 30).floor()} months ago';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return context.locale == Locale("am")
          ? (numericDates)
              ? 'ከ 1 ወር በፊት'
              : 'ባለፈው ወር'
          : (numericDates)
              ? '1 month ago'
              : 'A month ago';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return context.locale == Locale("am")
          ? 'ከ ${(difference.inDays / 7).floor()} ሳምንታት በፊት'
          : '${(difference.inDays / 7).floor()} weeks ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return context.locale == Locale("am")
          ? (numericDates)
              ? 'ከ 1 ሳምንት በፊት'
              : 'ባለፈው ሳምንት'
          : (numericDates)
              ? '1 week ago'
              : 'Last week';
    } else if (difference.inDays >= 2) {
      return context.locale == Locale("am")
          ? 'ከ ${difference.inDays} ቀናት በፊት'
          : '${difference.inDays} weeks ago';
    } else if (difference.inDays >= 1) {
      return context.locale == Locale("am")
          ? (numericDates)
              ? 'ከ 1 ቀን በፊት'
              : 'ትላንት'
          : (numericDates)
              ? '1 day ago'
              : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return context.locale == Locale("am")
          ? 'ከ ${difference.inHours} ሰዓታት በፊት'
          : '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return context.locale == Locale("am")
          ? (numericDates)
              ? 'ከ 1 ሰዓት በፊት'
              : 'ከሰዓት በፊት'
          : (numericDates)
              ? '1 hour ago'
              : 'A hour ago';
    } else if (difference.inMinutes >= 2) {
      return context.locale == Locale("am")
          ? 'ከ ${difference.inMinutes} ደቂቃዎች በፊት'
          : '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return context.locale == Locale("am")
          ? (numericDates)
              ? 'ከ 1 ደቂቃ በፊት'
              : 'ከደቂቃ በፊት'
          : (numericDates)
              ? '1 minute ago'
              : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return context.locale == Locale("am")
          ? 'ከ ${difference.inSeconds} ሰከንዶች በፊት'
          : '${difference.inSeconds} seconds ago';
    } else {
      return context.locale == Locale("am")? 'አሁን': "Now";
    }
  }
}
