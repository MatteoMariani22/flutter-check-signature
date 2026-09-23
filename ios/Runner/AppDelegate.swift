import UIKit
import Flutter
import flutter_downloader
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate {
    private let CHANNEL = "SIGNATURE_CHANNEL"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)

        // This is required to make any communication available in the action isolate.
        FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
            GeneratedPluginRegistrant.register(with: registry)
        }

        if let flutterViewController = window?.rootViewController as? FlutterViewController {
            let methodChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: flutterViewController.binaryMessenger)
            methodChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: FlutterResult) in
                if call.method == "validRelease" {
                    // Perform platform-specific operations and obtain the result
                    let data = validRelease()

                    // Send the result back to Flutter
                    result(data)
                } else {
                    result(FlutterMethodNotImplemented)
                }
            }
        }



        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

private func registerPlugins(registry: FlutterPluginRegistry) {
    if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
        FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
    }
}

func validRelease() -> Bool {
    let releaseMode: UIApplication.ReleaseMode = UIApplication().releaseMode()
    return releaseMode == UIApplication.ReleaseMode.appStore;
}
