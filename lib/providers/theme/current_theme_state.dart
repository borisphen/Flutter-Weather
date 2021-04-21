import 'package:flutter/foundation.dart';

@immutable
class CurrentThemeState {
  final bool isLightTheme;

  const CurrentThemeState({
    @required this.isLightTheme,
  });

  factory CurrentThemeState.initial(){
    return CurrentThemeState(isLightTheme: true);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentThemeState &&
          runtimeType == other.runtimeType &&
          isLightTheme == other.isLightTheme;

  @override
  int get hashCode => isLightTheme.hashCode;

  CurrentThemeState copyWith({
    bool isLightTheme,
  }) {
    if ((isLightTheme == null || identical(isLightTheme, this.isLightTheme))) {
      return this;
    }

    return new CurrentThemeState(
      isLightTheme: isLightTheme ?? this.isLightTheme,
    );
  }
}