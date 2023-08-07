import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/result.dart';
import 'package:loshical/result_notifier.dart';

final resultProvider = StateNotifierProvider<ResultNotifier, Result?>((ref) {
  return ResultNotifier();
});
