import 'package:chatbot/utils/utils.dart';
import 'package:hive/hive.dart';

part 'user_state.g.dart';

@HiveType(typeId: 2)
class UserState {
  UserState({
    this.isLoggedIn,
    this.hasStartedConvoWithBot,
    this.themeMode = Strings.darkThemeMode,
    this.loginType,
    this.hasOnboarded,
  });

  @HiveField(0)
  final bool isLoggedIn;
  @HiveField(1)
  final bool hasStartedConvoWithBot;
  @HiveField(2)
  final String themeMode;
  @HiveField(3)
  final String loginType;
  @HiveField(4)
  final bool hasOnboarded;

  UserState copyWith({
    bool isLoggedIn,
    bool hasStartedConvoWithBot,
    String themeMode,
    String loginType,
    bool hasOnboarded,
  }) {
    return UserState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      hasStartedConvoWithBot: hasStartedConvoWithBot ?? this.hasOnboarded,
      themeMode: themeMode ?? this.themeMode,
      loginType: loginType ?? this.loginType,
      hasOnboarded: hasOnboarded ?? this.hasOnboarded,
    );
  }
}
