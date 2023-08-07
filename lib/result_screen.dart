import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/answer_image.dart';
import 'package:loshical/assets.dart';
import 'package:loshical/hugged_child.dart';
import 'package:loshical/providers.dart';

class ResultScreen extends HookConsumerWidget {
  String? id;
  ResultScreen({super.key, this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(resultProvider);
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (id != null)
            HuggedChild(
                child: AnswerImage(
                    assetPath: AssetManager.path(
                        id: int.parse(id!), assetType: AssetType.answer))),
          if (result != null && result.isCorrect)
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text("Congratulations"),
            ),
          if (result != null && !result.isCorrect)
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text("Failed"),
            ),
          if (result != null)
            Text(
                'Last Image ID: ${result.imageId}\nIs Correct: ${result.isCorrect}')
          else
            const Text('No result available'),
          TextButton(
              onPressed: () {
                context.go("/");
              },
              child: const Text("Reset"))
        ],
      ),
    );
  }
}
