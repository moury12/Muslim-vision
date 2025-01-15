// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:meta/meta.dart';

import '../../../database/boxes.dart';

part 'home_screen_names_of_allah_event.dart';

part 'home_screen_names_of_allah_state.dart';

class HomeScreenNamesOfAllahBloc
    extends Bloc<HomeScreenNamesOfAllahEvent, HomeScreenNamesOfAllahState> {
  HomeScreenNamesOfAllahBloc() : super(HomeScreenNamesOfAllahInitialState()) {
    /*--------------------------------------- Variables ----------------------------------------*/
    final Box namesOfAllahBox = Boxes().namesOfAllahBox;
    List namesOfAllah = namesOfAllahBox.get('namesOfAllahBox');
    late CardSwiperController controller;
    bool isPlaying = false;
    AudioPlayer player = AudioPlayer();
    bool isVolumeOn = true;
    /*--------------------------------------- Functions ----------------------------------------*/
    void playStream() {
      player.playerStateStream.listen((playerState) {
        if (playerState.playing == true) {
          isPlaying = true;
          add(HomeScreenNamesOfAllahPlayEvent());
        }
        if (playerState.processingState == ProcessingState.completed) {
          isPlaying = false;
          add(HomeScreenNamesOfAllahPlayEvent());
        }
      });
    }

    Future playAudio(int currentIndex) async {
      try {
        await player.setAudioSource(
          ConcatenatingAudioSource(children: [
            AudioSource.uri(
              Uri.parse(namesOfAllahBox.get('namesOfAllahBox')[currentIndex]
                  ['audio_url']),
              tag: MediaItem(
                id: currentIndex.toString(),
                title: namesOfAllahBox.get('namesOfAllahBox')[currentIndex]
                    ['name_in_bangla'],
                artUri: Uri.parse(
                    'https://images.unsplash.com/photo-1601191362988-ac6ebec629c8?q=80&w=2535&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
              ),
            ),
          ]),
        );
      } on PlatformException {
        // print('PlatFormException');
      } catch (e) {
        // print(e);
      }
    }

    on<HomeScreenNamesOfAllahLoadedEvent>((event, emit) {
      player = AudioPlayer();
      controller = event.controller;
      emit(HomeScreenNamesOfAllahLoadedState(namesOfAllah));
    });
    on<HomeScreenNamesOfAllahSwipeEvent>((event, emit) async {
      await playAudio(event.currentIndex);
      if (isVolumeOn == true) {
        await player.setVolume(1);
      } else {
        await player.setVolume(0);
        return;
      }
      playStream();
      await player.play();
    });
    on<HomeScreenNamesOfAllahPlayAndPauseEvent>((event, emit) async {
      await playAudio(event.nameIndex - 2);
      if (isVolumeOn == true) {
        await player.setVolume(1);
      } else {
        await player.setVolume(0);
        return;
      }
      playStream();
      await player.play();
    });

    on<HomeScreenNamesOfAllahPlayEvent>((event, emit) {
      emit(HomeScreenNamesOfAllahIsPlayingState(isPlaying));
      emit(HomeScreenNamesOfAllahLoadedState(namesOfAllah));
    });

    on<HomeScreenNamesOfAllahIsVolumeOnEvent>((event, emit) {
      isVolumeOn = !isVolumeOn;
      emit(HomeScreenNamesOfAllahIsVolumeOnState(isVolumeOn));
      emit(HomeScreenNamesOfAllahLoadedState(namesOfAllah));
    });

    on<HomeScreenNamesOfAllahResetEvent>((event, emit) {
      for (int i = event.nameIndex; i >= 0; i--) {
        controller.undo();
      }
    });

    on<HomeScreenNamesOfAllahDisposeEvent>((event, emit) async {
      await player.stop();
      await player.dispose();
    });
  }
}
