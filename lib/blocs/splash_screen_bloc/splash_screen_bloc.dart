// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muslim_vision/controllers/repositories.dart';
import 'package:muslim_vision/controllers/services/common_functions.dart';
import 'package:muslim_vision/database/boxes.dart';
import '../../models/api_status_model.dart';
part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitialState()) {
    final utilBox = Boxes().utilsBox;
    final syncBox = Boxes().syncBox;
    final today = DateTime.now().toString().split(' ').first;
    getErrorMsg(String error) {
      return kDebugMode ? error : 'Error 404';
    }

    on<SplashScreenLoadedEvent>((event, emit) async {
      navigateToHomePageOnErrorIfCachedData() {
        if (!CommonFunctions.isAllBoxEmpty()) {
          emit(SplashScreenLoadedState());
        }
      }

      emit(SplashScreenLoadingState()); // Show loading state initially
      // await Future.delayed(const Duration(seconds: 3));
      // final isSynced = utilBox.get('isSynced', defaultValue: false); // Check if data has already been synced

      // if (isSynced == true && syncBox.isNotEmpty) {
      //   await Future.delayed(const Duration(seconds: 2));
      //   emit(SplashScreenLoadedState()); // Navigate to home screen
      //   return;
      // } else
      if (await CommonFunctions().hasInternetConnection()) {
        int currentMessageIndex = 0;
        List<String> messages = ["syncing_for_the_first_time".tr(), "slow_internet_please_wait".tr(), "please_wait".tr(), "hold_up_almost_done".tr(), "just_a_moment".tr()];

        //int index = 0;
        Timer? periodicTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
          currentMessageIndex = (currentMessageIndex + 1) % messages.length;
          if (!emit.isDone) {
            emit(SplashScreenSyncState(messages[currentMessageIndex]));
          } else {
            timer.cancel(); // Stop the timer if emit is completed
          } // emit(SyncTextUpdated(messages[index]));
        });
        if (syncBox.isEmpty) {
          // First Time Install: Fetch data, set sync data, and check API status
          try {
            await Repositories().getDMPathData();
            Map? syncData = await Repositories().syncApiFatch(utilBox.get('notification') != null ? await CommonFunctions().getDeviceToken() : "Notification Not Allow");
            if (syncData != null) {
              await CommonFunctions().setSyncDataInHive(syncData);
            }
          } catch (e) {
            if (await CommonFunctions().hasInternetConnection()) {
              emit(SplashScreenErrorState(errorMsg: getErrorMsg(e.toString())));
              navigateToHomePageOnErrorIfCachedData();
              return;
            } else {
              return emit(SplashScreenMessageState(msg: 'No Internet'));
            }
          }

          // emit(SplashScreenLoadingState());
          // Call API and Check Status

          ApiStatusModel apiStatus = await Repositories.processAllApiAndGetStatus();

          if (!apiStatus.isSuccess) {
            if (await CommonFunctions().hasInternetConnection()) {
              emit(SplashScreenErrorState(errorMsg: getErrorMsg(apiStatus.errorMsg)));
              navigateToHomePageOnErrorIfCachedData();
              periodicTimer.cancel();
              return;
            } else {
              return emit(SplashScreenMessageState(msg: 'No Internet'));
            }
          }

          utilBox.put('date', today);
          emit(SplashScreenLoadedState());
        } else {
          debugPrint('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
          debugPrint(today);
          debugPrint(utilBox.get('date'));
          if (today != utilBox.get('date')) {
            // Second Time Date Change: Fetch data and set sync data
            try {
              await Repositories().getDMPathData();

              Map? syncData = await Repositories().syncApiFatch(utilBox.get('notification') != null ? await CommonFunctions().getDeviceToken() : "Notification Not Allow");
              if (syncData != null) {
                await CommonFunctions().setSyncDataInHive(syncData);
              }
            } catch (e) {
              if (await CommonFunctions().hasInternetConnection()) {
                emit(SplashScreenErrorState(errorMsg: getErrorMsg(e.toString())));
                navigateToHomePageOnErrorIfCachedData();
                return;
              } else {
                return emit(SplashScreenMessageState(msg: 'No Internet'));
              }
            }
          }

          emit(SplashScreenLoadingState());
          // Call API and Check Status
          ApiStatusModel apiStatus = await Repositories.processAllApiAndGetStatus();
          if (!apiStatus.isSuccess) {
            if (await CommonFunctions().hasInternetConnection()) {
              emit(SplashScreenErrorState(errorMsg: getErrorMsg(apiStatus.errorMsg)));
              navigateToHomePageOnErrorIfCachedData();
              return;
            } else {
              return emit(SplashScreenMessageState(msg: 'No Internet'));
            }
          }

          utilBox.put('date', today);
          emit(SplashScreenLoadedState());
        }
      } else {
        if (syncBox.isNotEmpty) {
          // No Internet, but there is cached data
          emit(SplashScreenLoadedState());
        } else {
          // No Internet and no cached data
          emit(SplashScreenMessageState(msg: 'No Internet'));
        }
      }
    });
  }
}
