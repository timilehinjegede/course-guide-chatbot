import 'package:chatbot/logic/cubits/cubits.dart';
import 'package:chatbot/presentation/screens/home/home.dart';
import 'package:chatbot/presentation/widgets/widgets.dart';
import 'package:chatbot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: lightColors.kOrange,
                  ),
                  child: Center(
                    child: Text(
                      '🤖',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
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
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: lightColors.kGreen.withOpacity(.5),
          ),
        ),
        YBox(10),
        Text(
          'Hey Human! 👋🏾',
        ),
        YBox(10),
        Text(
          'Sign in to your account to start using chatbot name',
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
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => Home()),
            (route) => false,
          );
        } else if (state is AuthFailed) {
          Logger.info('authentication failed here');
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            AuthButton(
              title: Strings.signInWithFacebook,
              imgSrc: Assets.ic_facebook,
              onPressed: () async => _authCubit.signInWithFacebook(),
            ),
            YBox(15),
            AuthButton(
              title: Strings.signInWithGoogle,
              imgSrc: Assets.ic_google,
              onPressed: () async => _authCubit.signInWithGoogle(),
            ),
            YBox(15),
            AuthButton(
              title: Strings.signInWithApple,
              imgSrc: '',
              onPressed: () async => _authCubit.signInWithApple(),
            ),
          ],
        );
      },
    );
  }
}
