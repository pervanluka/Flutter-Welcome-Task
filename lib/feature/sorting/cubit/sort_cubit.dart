import 'dart:isolate';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

part 'sort_state.dart';

class SortCubit extends Cubit<SortState> {
  SortCubit() : super(SortInitial());

  // void handleButtonPress() async {
  //   final stopwatch = Stopwatch()..start();

  //   final random = Random();
  //   final randomNumbers =
  //       List.generate(25000000, (_) => random.nextInt(100000));
  //   emit(SortLoading());

  //   await compute(
  //       (message) => quickSort(message, 0, message.length - 1), randomNumbers);

  //   // isolate.kill();
  //   stopwatch.stop();
  //   final runtime = 'Time taken: ${stopwatch.elapsed.inSeconds} seconds';
  //   stopwatch.reset();
  //   emit(SortReady(runtime));
  // }

  Future<void> onButtonPressed() async {
    emit(SortLoading());

    final receivePort = ReceivePort();
    await Isolate.spawn(heavyTask, receivePort.sendPort);

    receivePort.listen(
      (model) {
        final data = model as HeavyTaskModel;
        print('num.length: ${data.randomNumbers.length}');
        print('num[0]: ${data.randomNumbers[0]}');
        print('num[1]: ${data.randomNumbers[1]}');
        print('num[2]: ${data.randomNumbers[2]}');
        print('num[3]: ${data.randomNumbers[3]}');

        emit(SortReady('timeTaken'.tr(args: [data.duration.toString()])));
      },
    );
  }
}

class HeavyTaskModel {
  int duration;
  List<int> randomNumbers;

  HeavyTaskModel({
    required this.duration,
    required this.randomNumbers,
  });
}

heavyTask(SendPort sendPort) {
  Stopwatch stopwatch = Stopwatch()..start();

  final random = Random();
  final randomNumbers = List.generate(25000000, (_) => random.nextInt(100000));

  stopwatch.stop();
  sendPort.send(HeavyTaskModel(
      duration: stopwatch.elapsed.inSeconds, randomNumbers: randomNumbers));
}

void quickSort(List<int> list, int leftIndex, int rightIndex) {
  if (leftIndex < rightIndex) {
    final pivotIndex = partition(list, leftIndex, rightIndex);
    quickSort(list, leftIndex, pivotIndex - 1);
    quickSort(list, pivotIndex + 1, rightIndex);
  }
}

int partition(List<int> list, int leftIndex, int rightIndex) {
  final pivot = list[rightIndex];
  var i = leftIndex - 1;

  for (var j = leftIndex; j < rightIndex; j++) {
    if (list[j] <= pivot) {
      i++;
      final temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
  }

  final temp = list[i + 1];
  list[i + 1] = list[rightIndex];
  list[rightIndex] = temp;

  return i + 1;
}
