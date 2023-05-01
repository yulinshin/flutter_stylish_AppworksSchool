import UIKit
import Flutter
import TPDirect
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    var flutterVC: FlutterViewController?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        GMSServices.provideAPIKey("AIzaSyCn7rgnjHBa7T2NeamSXEwrh3gcDkhka8k")
        TPDSetup.setWithAppId(12348, withAppKey: "app_pa1pQcKoY22IlnSXq5m5WP5jFKzoRG58VEXpT7wU62ud7mMbDOGzCYIlzzLF", with: TPDServerType.sandBox)

        if let flutterViewController: FlutterViewController = window?.rootViewController as? FlutterViewController {
            self.flutterVC = flutterViewController
            let channel = FlutterMethodChannel(name: "iOSChannel", binaryMessenger: flutterViewController.binaryMessenger)
            channel.setMethodCallHandler(handle)
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "presentTapPayView" {
            let tpdCardVC = TapPayViewController()
            flutterVC?.present(tpdCardVC, animated: true)
            tpdCardVC.didPayAction = { prime in
                guard let flutterVC = self.flutterVC else { return }
                let channel = FlutterMethodChannel(name: "payments", binaryMessenger: flutterVC.binaryMessenger)
                channel.invokeMethod("paymentSuccess", arguments: ["prime": prime])
            }
            result(nil)
        }
    }
}
