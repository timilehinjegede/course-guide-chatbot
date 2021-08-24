import 'package:chatbot/data/models/user_state.dart';
import 'package:chatbot/data/services/storage/storage_service.dart';
import 'package:chatbot/logic/cubits/cubits.dart';
import 'package:chatbot/presentation/screens/home/home.dart';
import 'package:chatbot/presentation/widgets/widgets.dart';
import 'package:chatbot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Apollo'.toUpperCase(),
                style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2.5
                    ..color = lightColors.primary
                    ..strokeCap = StrokeCap.round,
                ),
              ),
              _AuthBasicInfoSection(),
              _AuthButtonsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthBasicInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/chatbot_3.svg',
          height: 200,
        ),
        YBox(10),
        Text(
          'Hi Human! 👋🏾',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: lightColors.text,
          ),
        ),
        YBox(10),
        Text.rich(
          TextSpan(
            text: 'Sign in to your account to start using ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: lightColors.subText,
              height: 1.3,
            ),
            children: [
              TextSpan(
                text: 'APOLLO',
                style: TextStyle(
                  color: lightColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _AuthButtonsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authCubit = context.watch<AuthCubit>();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          Logger.info('authentication loaidng here');
        } else if (state is AuthSuccess) {
          Logger.info('authentication in success here');
          // mutate user state
          StorageService storageService = StorageService();
          UserState userState = storageService.getUserState();
          userState = userState.copyWith(isLoggedIn: true, hasOnboarded: true);
          storageService.saveUserState(userState: userState);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => Home(),
            ),
            (route) => false,
          );
        } else if (state is AuthFailed) {
          WidgetsHelper.showErrorDialog(
            context,
            state.errorMessage,
          );
          Logger.info('authentication failed here');
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            AuthButton(
              title: Strings.signInWithFacebook.toUpperCase(),
              imgSrc: 'assets/images/facebook.png',
              onPressed: () async => _authCubit.signInWithFacebook(context),
              textColor: lightColors.white,
            ),
            YBox(15),
            AuthButton(
              title: Strings.signInWithGoogle.toUpperCase(),
              imgSrc: 'assets/images/google.png',
              onPressed: () async => _authCubit.signInWithGoogle(context),
              textColor: lightColors.white,
            ),
            // YBox(15),
            // AuthButton(
            //   title: Strings.signInWithApple,
            //   imgSrc: '',
            //   onPressed: () async => _authCubit.signInWithApple(),
            // ),
          ],
        );
      },
    );
  }
}
