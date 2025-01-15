// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:vibration/vibration.dart';

import '../../../database/boxes.dart';

part 'tasbeeh_animation_event.dart';
part 'tasbeeh_animation_state.dart';

class TasbeehAnimationBloc extends Bloc<TasbeehAnimationEvent, TasbeehAnimationState> {
  TasbeehAnimationBloc() : super(TasbeehAnimationInitialState()) {
    /*-------------------------Variables----------------------*/
    int counter = 0;
    int target = 0;
    int loop = 1;
    late AnimationController controller;
    late Map singleDhikrData;
    /*-------------------------Counter Events----------------------*/
    on<TasbeehAnimationInitialEvent>((event, emit) {
      controller = event.controller;
    });
    on<TasbeehAnimationResetEvent>((event, emit) {
      counter = 0;
      loop = 1;
      emit(TasbeehAnimationLoopState(loop));
      emit(TasbeehAnimationCounterState(counter = 0));
    });
    on<TasbeehAnimationSingleDhikrEvent>((event, emit) {
      target = event.singleDhikrData['count'];
      loop = 1;
      singleDhikrData = event.singleDhikrData;
      emit(TasbeehAnimationSingleDhikrState(singleDhikrData));
      emit(TasbeehAnimationLoopState(loop));
      emit(TasbeehAnimationCounterState(counter = 0));
    });
    on<TasbeehAnimationCounterEvent>((event, emit) async {
      if (counter >= 0) {
        controller.reverse(from: 1);
        counter++;
      }
      if (counter > target) {
        Vibration.vibrate(duration: 500);

        loop++;
        counter = 1;

        emit(TasbeehAnimationLoopState(loop));
        emit(TasbeehAnimationCounterState(counter));
      } else {
        emit(TasbeehAnimationCounterState(counter));
      }
      if (event.count == 0) {
        await CommonFunctions().playSound("audios/click.mp3");

        emit(TasbeehSoundState(count: event.count));
      } else if (event.count == 1) {
        Vibration.vibrate(duration: 50);
      }
    });
    on<TasbeehAnimationDragEndEvent>((event, emit) async {
      if (event.details > 0 && counter >= 0) {
        // print('left to right');
        controller.reverse(from: 1);
        counter++;
        if (event.count == 0) {
          await CommonFunctions().playSound("audios/click.mp3");

          emit(TasbeehSoundState(count: event.count));
        } else if (event.count == 1) {
          Vibration.vibrate(duration: 50);
          emit(TasbeehSoundState(count: event.count));
        }
      } else {
        // print('right to left');
        if (counter > 0) {
          controller.forward(from: 0);
          counter--;
          if (event.count == 0) {
            await CommonFunctions().playSound("audios/backward.mp3");

            emit(TasbeehSoundState(count: event.count));
          } else if (event.count == 1) {
            Vibration.vibrate(duration: 50);
            emit(TasbeehSoundState(count: event.count));
          }
        }
      }
      if (counter > target) {
        loop++;
        counter = 1;
        emit(TasbeehAnimationLoopState(loop));
        emit(TasbeehAnimationCounterState(counter));
      } else {
        emit(TasbeehAnimationCounterState(counter));
      }
    });
    on<TasbeehAnimationLoadedEvent>((event, emit) async {
      final Box dhikrBox = Boxes().tasbeehBox;
      Map initialDhikrData = dhikrBox.get('TasbeehInitialData');
      counter = initialDhikrData['counter'];
      loop = initialDhikrData['loop'];
      singleDhikrData = initialDhikrData['singleDhikrData'];
      emit(TasbeehAnimationSingleDhikrState(initialDhikrData['singleDhikrData']));
      emit(TasbeehAnimationLoopState(initialDhikrData['loop']));
      emit(TasbeehAnimationCounterState(initialDhikrData['counter']));
    });
    on<TasbeehAnimationInitialDataSaveEvent>((event, emit) async {
      final Box dhikrBox = Boxes().tasbeehBox;
      Map tasbeehInitialData = {
        'counter': counter,
        'loop': loop,
        'singleDhikrData': singleDhikrData,
      };
      await dhikrBox.put('TasbeehInitialData', tasbeehInitialData);
    });

    //-------------------------Sound on Off--------------------
    on<TasbeehSoundEvent>(((event, emit) {
      emit(TasbeehSoundState(count: event.count));
    }));
  }
}
