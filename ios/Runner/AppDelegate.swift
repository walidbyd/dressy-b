import UIKit
import Flutter
import Firebase
import Braintree
import GoogleMaps
import google_mobile_ads
import app_links

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {  
    if FirebaseApp.app() == nil {
        FirebaseApp.configure()
    }
    // GMSServices.provideAPIKey("AI00000000000000000000-0000000000000000")
    GMSServices.provideAPIKey("AIzaSyATAyoY0jwNqHA281sFD9JkgBYaqgF6KHE")
    
    GeneratedPluginRegistrant.register(with: self)


        // COMPLETE: REgister ListTileNativeAdFactory
    let listTileFactory = ListTileNativeAdFactory()
    FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
        self, factoryId: "listTile", nativeAdFactory: listTileFactory)
        
    BTAppContextSwitcher.setReturnURLScheme("com.dressy.app.braintree")
       
   if #available(iOS 10.0, *) {
     UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
   }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions);
  }
  

  override
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
    if url.scheme?.localizedCaseInsensitiveCompare("com.dressy.app.braintree") == .orderedSame {
        return BTAppContextSwitcher.handleOpenURL(url)
    }else if url.scheme?.localizedCaseInsensitiveCompare("com.dressy.app.app") == .orderedSame {
        if let url = AppLinks.shared.getLink(launchOptions: options) {
          // We have a link, propagate it to your Flutter app or not
          AppLinks.shared.handleLink(url: url)
          return true // Returning true will stop the propagation to other packages
        }
        
        AppLinks.shared.handleLink(url: url)
    }
    return false
  }

// If you support iOS 8, add the following method.
override
func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
    if url.scheme?.localizedCaseInsensitiveCompare("com.dressy.app.braintree") == .orderedSame {
        return BTAppContextSwitcher.handleOpenURL(url)
    }
    return false
}
  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let firebaseAuth = Auth.auth()
        firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.unknown)

    }
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let firebaseAuth = Auth.auth()
        if (firebaseAuth.canHandleNotification(userInfo)){
            print(userInfo)
            return
        }
    }
}
//FLTGoogleMobileAdsPlugin
