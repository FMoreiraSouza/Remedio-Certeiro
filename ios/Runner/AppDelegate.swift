import UIKit
import Flutter
import AudioToolbox

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  
  private var alarmSoundID: SystemSoundID = 0
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let alarmChannel = FlutterMethodChannel(name: "alarm_channel",
                                            binaryMessenger: controller.binaryMessenger)
    alarmChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "playAlarm" {
        self.playAlarm()
        result(nil)
      } else if call.method == "stopAlarm" {
        self.stopAlarm()
        result(nil)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func playAlarm() {
    if alarmSoundID == 0 {
      AudioServicesCreateSystemSoundID(SystemSoundID(kSystemSoundID_Vibrate), &alarmSoundID)
    }
    AudioServicesPlaySystemSound(alarmSoundID)
  }
  
  private func stopAlarm() {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
  }
}
