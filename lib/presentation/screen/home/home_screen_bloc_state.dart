import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tcp_penguin/presentation/screen/home/home_screen_bloc_effect.dart';

class HomeScreenBlocState extends Equatable {
  final bool isLoading;

  final double progress;
  final String progressText;

  final String scanResultHost;
  final String scanResultOpenPorts;
  final String scanResultDuration;

  final String formHost;
  final int formPortStart;
  final int formPortEnd;
  final int formWorkers;
  final int formTimeout;

  final String? formHostError;
  final String? formPortStartError;
  final String? formPortEndError;
  final String? formWorkersError;
  final String? formTimeoutError;

  final HomeScreenBlocEffect? effect;

  const HomeScreenBlocState({
    required this.isLoading,

    required this.progress,
    required this.progressText,

    required this.scanResultHost,
    required this.scanResultOpenPorts,
    required this.scanResultDuration,

    required this.formHost,
    required this.formPortStart,
    required this.formPortEnd,
    required this.formWorkers,
    required this.formTimeout,

    required this.formHostError,
    required this.formPortStartError,
    required this.formPortEndError,
    required this.formWorkersError,
    required this.formTimeoutError,

    required this.effect,
  });

  factory HomeScreenBlocState.initial() => HomeScreenBlocState(
    isLoading: false,

    progress: 0.0,
    progressText: 'Ready to scan',

    scanResultHost: 'Host: ',
    scanResultOpenPorts: 'Open ports: ',
    scanResultDuration: 'Duration: ',

    formHost: 'scanme.nmap.org',
    formPortStart: 1,
    formPortEnd: 255,
    formWorkers: 100,
    formTimeout: 5000,

    formHostError: null,
    formPortStartError: null,
    formPortEndError: null,
    formWorkersError: null,
    formTimeoutError: null,

    effect: null,
  );

  HomeScreenBlocState copyWith({
    bool? isLoading,

    double? progress,
    String? progressText,

    String? scanResultHost,
    String? scanResultOpenPorts,
    String? scanResultDuration,

    String? formHost,
    int? formPortStart,
    int? formPortEnd,
    int? formWorkers,
    int? formTimeout,

    ValueGetter<String?>? formHostError,
    ValueGetter<String?>? formPortStartError,
    ValueGetter<String?>? formPortEndError,
    ValueGetter<String?>? formWorkersError,
    ValueGetter<String?>? formTimeoutError,

    HomeScreenBlocEffect? effect,
  }) {
    return HomeScreenBlocState(
      isLoading: isLoading ?? this.isLoading,

      progress: progress ?? this.progress,
      progressText: progressText ?? this.progressText,

      scanResultHost: scanResultHost ?? this.scanResultHost,
      scanResultOpenPorts: scanResultOpenPorts ?? this.scanResultOpenPorts,
      scanResultDuration: scanResultDuration ?? this.scanResultDuration,

      formHost: formHost ?? this.formHost,
      formPortStart: formPortStart ?? this.formPortStart,
      formPortEnd: formPortEnd ?? this.formPortEnd,
      formWorkers: formWorkers ?? this.formWorkers,
      formTimeout: formTimeout ?? this.formTimeout,

      formHostError: formHostError != null
          ? formHostError()
          : this.formHostError,
      formPortStartError: formPortStartError != null
          ? formPortStartError()
          : this.formPortStartError,
      formPortEndError: formPortEndError != null
          ? formPortEndError()
          : this.formPortEndError,
      formWorkersError: formWorkersError != null
          ? formWorkersError()
          : this.formWorkersError,
      formTimeoutError: formTimeoutError != null
          ? formTimeoutError()
          : this.formTimeoutError,
      effect: effect ?? this.effect,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,

    progress,
    progressText,

    scanResultHost,
    scanResultOpenPorts,
    scanResultDuration,

    formHost,
    formPortStart,
    formPortEnd,
    formWorkers,
    formTimeout,

    formHostError,
    formPortStartError,
    formPortEndError,
    formWorkersError,
    formTimeoutError,

    effect,
  ];
}
