
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loshical/answer_image.dart';
import 'package:loshical/assets.dart';
import 'package:loshical/how_to_play_screen.dart';
import 'package:loshical/hugged_child.dart';
import 'package:loshical/providers.dart';
import 'package:loshical/question_image.dart';

class QuestionScreen extends HookConsumerWidget {
  QuestionScreen({super.key});
  late final BuildContext _context;
  late final WidgetRef _ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _context = context;
    _ref = ref;
    int qI = 0;
    int aI = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loshical'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => const HowToPlayScreen()));
            },
            icon: const Icon(Icons.info_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              const Text('Choose the image that completes the pattern: '),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                children: AssetManager.questionPaths.map(
                  (e) {
                    qI++;
                    return getDragTarget(e, qI);
                  },
                ).toList(),
              ),
              const Spacer(),
              const Text('Which of the shapes below continues the sequence'),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                direction: Axis.horizontal,
                children: AssetManager.answerPaths.map((e) {
                  aI++;
                  return getDraggable(e, aI);
                }).toList(),
              ),
              const SizedBox(
                height: 42,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getDraggable(String assetPath, int aI) {
    return Draggable<int>(
      data: aI,
      feedback: HuggedChild(
        child: Container(
          // width: 100,
          // height: 100,
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.blue,
            width: 2.0,
          )),
          child: Center(
              child: AnswerImage(
            assetPath: assetPath,
          )),
        ),
      ), // Unique identifier for the item
      child: HuggedChild(
        child: Container(
          // width: 100,
          // height: 100,
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.black,
            width: 2.0,
          )),
          child: Center(
              child: AnswerImage(
            assetPath: assetPath,
          )),
        ),
      ),
    );
  }

  Widget getDragTarget(String assetPath, int qI) {
    if (qI==2) {
      return DragTarget<int>(
        builder: (BuildContext context, List<int?> candidateData,
            List<dynamic> rejectedData) {
          return HuggedChild(
            child: Container(
              // width: 150,
              // height: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(
                  color: candidateData.isNotEmpty
                      ? candidateData.first == 5
                          ? Colors.green
                          : Colors.red
                      : Colors.black, // Change border color based on acceptance
                  width: 2.0,
                ),
              ),
              child: Center(
                  child: QuestionImage(
                assetPath: assetPath,
              )),
            ),
          );
        },
        onWillAccept: (int? data) {
          //  debugPrint("onWillAccept $data");
          if (data != null) {
            if (data == 5) {
              _ref.read(resultProvider.notifier).updateResult(data, true);
            } else {
              _ref.read(resultProvider.notifier).updateResult(data, false);
            }
          }
          // return false;

          return true;
        },
        onAccept: (int data) {
           final result = _ref.watch(resultProvider);
          _context.go('/result/${result!.imageId}');
        },
      );
    } else {
      return QuestionImage(
        assetPath: assetPath,
      );
    }
  }
}
