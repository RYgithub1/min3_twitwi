import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeAgo;



/// [timeAgo向け、現在の端末の言語設定を取得、topLebelFunc]
String createTimeAgoString(DateTime postDateTime) {
  final currentLocale = Intl.getCurrentLocale();
  final now = DateTime.now();
  final difference = now.difference(postDateTime);
  return timeAgo.format(
    now.subtract(difference),   /// 引き算
    locale: currentLocale,
  );


}