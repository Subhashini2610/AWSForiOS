/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The application delegate.
*/

import UIKit
import Amplify
import AmplifyPlugins

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public let userData = UserData()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        do {
            Amplify.Logging.logLevel = .info
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            
            print("Amplify initialized")
            
            self.checkUserSignedIn()
            
            _ = Amplify.Hub.listen(to: .auth, listener: { (payload) in
                switch payload.eventName {
                case HubPayload.EventName.Auth.signedIn:
                    print("==HUB== User signed In, update UI")
                    
                    self.updateUI(forSignInStatus: true)
                    
                    _ = Amplify.Auth.fetchUserAttributes(listener: { (result) in
                        switch result {
                        case .success(let attributes):
                            print("User attributes - \(attributes)")
                        case .failure(let error):
                            print("Fetching user attributes failed with error \(error)")
                        }
                    })
                case HubPayload.EventName.Auth.signedOut:
                    print("==HUB== User signed Out, update UI")
                    self.updateUI(forSignInStatus: false)
                case HubPayload.EventName.Auth.sessionExpired:
                    print("==HUB== Session expired, show sign in aui")
                    self.updateUI(forSignInStatus: false)
                    
                default:
                    break
                }
            })
            
        } catch  {
            print("Failed to configure Amplify \(error)")
        }
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

//MARK: Auth code
extension AppDelegate {
    
    func updateUI(forSignInStatus: Bool) {
        DispatchQueue.main.async {
            self.userData.isSignedIn = forSignInStatus
        }
    }
    
    func checkUserSignedIn() {
        
        _ = Amplify.Auth.fetchAuthSession(listener: { (result) in
            do {
                let session = try result.get()
                self.updateUI(forSignInStatus: session.isSignedIn)
            } catch {
                print("Fetch auth session failed with error - \(error)")
            }
        })
        
    }
    
    //sign in with Cognito WEB UI
    public func authenticateWithHostedUI() {
        print("hostedUI()")
        
        _ = Amplify.Auth.signInWithWebUI(presentationAnchor: UIApplication.shared.windows.first!, listener: { (result) in
            switch result {
            case .success(_):
                print("Sign in succeeded")
            case .failure(let error):
                print("Sign in failed \(error)")
            }
        })
    }
    
    public func signOut() {
        let options = AuthSignOutRequest.Options(globalSignOut: true)
        
        _ = Amplify.Auth.signOut(options: options, listener: { (result) in
            switch result {
            case .success:
                print("Successfully signed out")
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        })
    }
    
}
