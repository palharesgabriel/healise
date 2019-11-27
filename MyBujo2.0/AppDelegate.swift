import UIKit
import CoreData
import UserNotifications
import CloudKit
import Onboard

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let defaults = UserDefaults.standard
        let userHasOnboarded = defaults.bool(forKey: "userHasOnboarded")
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        if userHasOnboarded {
            window.rootViewController = CustomNavigationController(rootViewController: MyJourneyViewController())
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "userHasOnboarded")
        } else {
            window.rootViewController = generateStandardOnboardingVC()
        }
        self.window = window
        UNUserNotificationCenter.current().delegate = self

        // Request permission from user to send notification
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { authorized, error in
            if authorized {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        })
        // Override point for customization after application launch.
        return true
    }
    

    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    // MARK: - Label Tutorial
    let firstpage1 = NSLocalizedString("tutorial",
    comment: "tutorial")
    let firstpage2 = NSLocalizedString("Scroll to start",
    comment: "Scroll to start")
    let secondPage1 = NSLocalizedString("You have your space to talk about feelings and your routine.",
    comment: "You have your space to talk about feelings and your routine.")
    let thirdPage1 = NSLocalizedString("Here you can express yourself in many ways.",
    comment: "Here you can express yourself in many ways.")
    
    // MARK: - Tutorial
    
    func generateStandardOnboardingVC () -> OnboardingViewController {
        // Initialize onboarding view controller
        var onboardingVC = OnboardingViewController()
        // Create slides
        let firstPage = OnboardingContentViewController.content(withTitle: firstpage1, body: firstpage2, image: UIImage(named: "tutorial01"), buttonText: nil, action: nil)
        let secondPage = OnboardingContentViewController.content(withTitle: "", body: secondPage1, image: UIImage(named: "tutorial2"), buttonText: nil, action: nil)
        let thirdPage = OnboardingContentViewController.content(withTitle: "", body: "Aqui você poderá se expressar de muitas maneiras..", image: UIImage(named: "tutorial3"), buttonText: nil, action: nil)
        
        
        let fourthPage = OnboardingContentViewController.content(withTitle: "", body: "Você pode criar lista de check list para mapear seu dia e se conhecer mais.", image: UIImage(named: "tutorial4"), buttonText: nil, action: self.handleOnboardingCompletion)
        let fifth = OnboardingContentViewController.content(withTitle: "", body: "A cada dia voce pode dizer como está se sentindo atraves de cores, para posteriormente poder olhar melhor, se analisar e se conhecer melhor.", image: UIImage(named: "tutorial5"), buttonText: nil, action: self.handleOnboardingCompletion)
        let sixth = OnboardingContentViewController.content(withTitle: "Tenha uma visão macro de você mesmo", body: "E quando você quiser lembrar sobre tal dia, é só tocar! 😄.", image: UIImage(named: "tutorial6"), buttonText: nil, action: self.handleOnboardingCompletion)
        let seventh = OnboardingContentViewController.content(withTitle: "Esse espaço é seu espaço seguro.", body: "Quanto mais você se expressar mais voce vai se entender.", image: UIImage(named: "tutorial7"), buttonText: "Começar", action: self.handleOnboardingCompletion)
        // Define onboarding view controller properties
        
        let colorBackground = UIColor(displayP3Red: 240/255, green: 243/255, blue: 255/255, alpha: 1.0)
        let colorLabelBlue = UIColor(displayP3Red: 116/255, green: 163/255, blue: 215/255, alpha: 1.0)
        
        firstPage.view.backgroundColor = colorBackground
        firstPage.topPadding = 160
        firstPage.titleLabel.textColor = colorLabelBlue
        firstPage.bodyLabel.textColor = colorLabelBlue
        
        secondPage.view.backgroundColor = colorBackground
        secondPage.titleLabel.textColor = colorLabelBlue
        secondPage.bodyLabel.textColor = colorLabelBlue
        secondPage.topPadding = 240
        
        
        thirdPage.view.backgroundColor = colorBackground
        thirdPage.bodyLabel.textColor = colorLabelBlue
        thirdPage.topPadding = 200
        
        fourthPage.view.backgroundColor = colorBackground
        fourthPage.bodyLabel.textColor = colorLabelBlue
        fourthPage.topPadding = 200
        
        fifth.view.backgroundColor = colorBackground
        fifth.bodyLabel.textColor = colorLabelBlue
        fifth.topPadding = 200

        sixth.view.backgroundColor = colorBackground
        sixth.bodyLabel.textColor = colorLabelBlue
        sixth.titleLabel.textColor = colorLabelBlue
        sixth.topPadding = 100
        
        seventh.view.backgroundColor = colorBackground
        seventh.bodyLabel.textColor = colorLabelBlue
        seventh.titleLabel.textColor = colorLabelBlue
        seventh.topPadding = 150
        
        
        
        
        
     
        onboardingVC = OnboardingViewController.onboard(withBackgroundImage: UIImage(named: "giga-banner"), contents: [firstPage, secondPage, thirdPage, fourthPage, fifth, sixth,seventh])
        onboardingVC.shouldFadeTransitions = true
        onboardingVC.shouldMaskBackground = false
        onboardingVC.shouldBlurBackground = false
        onboardingVC.fadePageControlOnLastPage = true
        onboardingVC.pageControl.pageIndicatorTintColor = UIColor.darkGray
        onboardingVC.pageControl.currentPageIndicatorTintColor = UIColor.white
        onboardingVC.skipButton.setTitleColor(UIColor.white, for: .normal)
        onboardingVC.allowSkipping = true
        onboardingVC.fadeSkipButtonOnLastPage = true
        onboardingVC.skipHandler = {
            self.skip()
        }
        return onboardingVC
    }
    func handleOnboardingCompletion() {
        self.setupNormalRootViewController()
    }
    
    func setupNormalRootViewController () {
        self.window?.rootViewController = MyJourneyViewController()
    }
    func skip() {
        self.window?.rootViewController = MyJourneyViewController()
    }
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "MyBujo2_0")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
        
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let subscription = CKQuerySubscription(recordType: "Notifications", predicate: NSPredicate(format: "TRUEPREDICATE"), options: .firesOnRecordCreation)
         
        let info = CKSubscription.NotificationInfo()
        info.titleLocalizationKey = "%1$@"
        info.titleLocalizationArgs = ["title"]
        
//        // if you want to use multiple field combined for the title of push notification
//         info.titleLocalizationKey = "%1$@ %2$@" // if want to add more, the format will be "%3$@", "%4$@" and so on
//         info.titleLocalizationArgs = ["title", "subtitle"]
        
        // this will use the 'content' field in the Record type 'notifications' as the content of the push notification
        info.alertLocalizationKey = "%1$@"
        info.alertLocalizationArgs = ["content"]
        
        info.soundName = "default"
        
        subscription.notificationInfo = info
         
        CKContainer.default().publicCloudDatabase.save(subscription, completionHandler: { subscription, error in
            if error == nil {
                print("deu bom")
                // Subscription saved successfully
            } else {
                print(error?.localizedDescription)
            }
        })
    }
    
    // This function will be called when the app receive notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    // This function will be called right after user tap on the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // tell the app that we have finished processing the user’s action (eg: tap on notification banner) / response
        completionHandler()
    }
}
