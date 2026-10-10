# flutter-check-signature

A Flutter snippet demonstrating an application-signature and release-integrity check.
In release builds, when the signature security option is enabled:

- **iOS:** calls native Swift code through a Flutter method channel to verify that the app is running as an App Store release.

If a check fails, the app routes to its security-blocked screen. These checks are intended as an additional integrity measure and do not replace other security controls.
