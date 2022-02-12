import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hydrated_isolate_example/counter/counter.dart';
import 'package:path_provider/path_provider.dart';

abstract class BackgroundWorker{
  
  static void init() async{
    final storageDirectory = kIsWeb
      ? HydratedStorage.webStorageDirectory
      : await getTemporaryDirectory();

    await Isolate.spawn(_initStorage, storageDirectory);
  }
}

void _initStorage(storageDirectory) async{

  await HydratedStorage.build(
    storageDirectory: storageDirectory
  ).then((storage){

    HydratedBlocOverrides.runZoned(
      () {
        final counterCubit = CounterCubit();
        counterCubit.reset();
      },
      storage: storage
    );
  });
}