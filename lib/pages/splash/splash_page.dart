import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:package_signature/package_signature.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:flutter-check-signature/models/app/check_version.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  ...

  ...

  late final FormGroup _form = FormGroup({
    ...
  });

  @override
  void initState() {
    super.initState();

    ...
  }

  @override
  void dispose() {
    ...

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<AppBloc, AppState>(
      listener: (context, state) => switch (state) {
            CheckedVersionState(:final checkVersion) => {
                ...
              },
            ErrorCheckingVersionState() => {
                ...
              },
            _ => null,
          },
      child: Scaffold(
        body: ...
      ));

  Future<void> _statusListener(AnimationStatus status) async {
    ...
  }

  Future<void> _evaluate(CheckVersion version, bool animationCompleted) async {
    ...

    if (kReleaseMode) {
      final securityConfig = F.securityConfig;

      if (securityConfig.secJailbreakRoot) {
        ...
      }

      if (securityConfig.secAppSignature) {
        ...

        if (Platform.isAndroid) {
          Signature? signature = await PackageSignature().signature;
          if (signature?.sha256hex.toUpperCase() != F.signature) {
            ...

            return;
          }
        }

        if (Platform.isIOS && F.isProd) {
          final platform = const MethodChannel('SIGNATURE_CHANNEL');

          try {
            final validRelease = await platform.invokeMethod<bool>('validRelease') ?? false;
            if (!validRelease) {
              context.router.push(const SecurityBlockedRoute());
              return;
            }
          } on PlatformException {
            context.router.push(const SecurityBlockedRoute());
            return;
          }
        }
      }
    }

    _checkVersion(version);
  }

  void _checkVersion(CheckVersion version) {
    FileUtils.deleteCacheDirectoryFiles();

    ...
  }
}
