import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/result.dart';

class ResultNotifier extends StateNotifier<Result?> {
  ResultNotifier() : super(null);

  void updateResult(int imageId, bool isCorrect) {
    state = Result(imageId: imageId, isCorrect: isCorrect);
  }
}
