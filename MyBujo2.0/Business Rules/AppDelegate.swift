import UIKit
import CoreData
import UserNotifications
import CloudKit
import Onboard

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    
    let rootViewController = CustomNavigationController(rootViewController: MyJourneyViewController())
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let defaults = UserDefaults.standard
        let userHasOnboarded = defaults.bool(forKey: "userHasOnboarded")
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        if userHasOnboarded {
            window.rootViewController = rootViewController
            let defaults = UserDefaults.standard
        } else {
            window.rootViewController = generateStandardOnboardingVC()
            defaults.set(true, forKey: "userHasOnboarded")
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
    let firstpage1 = NSLocalizedString("Tutorial",
    comment: "Tutorial")
    let firstpage2 = NSLocalizedString("Scroll to start",
    comment: "Scroll to start")
    let secondPage1 = NSLocalizedString("You have your space to talk about feelings and your routine.",
    comment: "You have your space to talk about feelings and your routine.")
    let thirdPage1 = NSLocalizedString("Here you can express yourself in many ways.",
    comment: "Here you can express yourself in many ways.")
    let fourthPage1 = NSLocalizedString("You can create checklists to map your day and get to know more.",
    comment: "You can create checklists to map your day and get to know more.")
    let fivethPage1 = NSLocalizedString("Each day you can input how you are feeling through the colors, later you can analyze yourself and improve your self knowledge.",
    comment: "Each day you can input how you are feeling through the colors, later you can analyze yourself and improve your self knowledge.")
    let sixthPage1 = NSLocalizedString("Get a macro view of yourself.",
    comment: "Get a macro view of yourself.")
    let sixthPage2 = NSLocalizedString("And when you want to remember about such a day, just click it! 😄",
    comment: "And when you want to remember about such a day, just click it! 😄")
    let seventhPage1 = NSLocalizedString("This is your safe space",
    comment:"This is your safe space")
    let seventhPage2 = NSLocalizedString("the more you express yourself the more you will self understand",
    comment:"the more you express yourself the more you will self understand")
    
    let seventhPage3 = NSLocalizedString("Start",
    comment:"Start")


    
    // MARK: - Tutorial
    
    func generateStandardOnboardingVC () -> OnboardingViewController {
        // Initialize onboarding view controller
        var onboardingVC = OnboardingViewController()
        // Create slides
        let firstPage = OnboardingContentViewController.content(withTitle: firstpage1, body: firstpage2, image: UIImage(named: "tutorial01"), buttonText: nil, action: nil)
        let secondPage = OnboardingContentViewController.content(withTitle: "", body: secondPage1, image: UIImage(named: "tutorial2"), buttonText: nil, action: nil)
        let thirdPage = OnboardingContentViewController.content(withTitle: "", body: thirdPage1, image: UIImage(named: "tutorial3"), buttonText: nil, action: nil)
        
        let fourthPage = OnboardingContentViewController.content(withTitle: "", body: fourthPage1, image: UIImage(named: "tutorial4"), buttonText: nil, action: self.handleOnboardingCompletion)
        let fifth = OnboardingContentViewController.content(withTitle: "", body: fivethPage1, image: UIImage(named: "tutorial5"), buttonText: nil, action: self.handleOnboardingCompletion)
        let sixth = OnboardingContentViewController.content(withTitle:sixthPage1, body: sixthPage2, image: UIImage(named: "tutorial6"), buttonText: nil, action: self.handleOnboardingCompletion)
        let seventh = OnboardingContentViewController.content(withTitle: seventhPage1, body: seventhPage2, image: UIImage(named: "tutorial7"), buttonText: seventhPage3, action: self.handleOnboardingCompletion)
        // Define onboarding view controller properties
        
        let colorBackground = UIColor(displayP3Red: 240/255, green: 243/255, blue: 255/255, alpha: 1.0)
        let colorLabelBlue = UIColor(displayP3Red: 116/255, green: 163/255, blue: 215/255, alpha: 1.0)
        
        firstPage.view.backgroundColor = colorBackground
        firstPage.titleLabel.textColor = colorLabelBlue
        firstPage.bodyLabel.textColor = colorLabelBlue
		
        secondPage.view.backgroundColor = colorBackground
        secondPage.titleLabel.textColor = colorLabelBlue
        secondPage.bodyLabel.textColor = colorLabelBlue
        
        thirdPage.view.backgroundColor = colorBackground
        thirdPage.bodyLabel.textColor = colorLabelBlue
	
        fourthPage.view.backgroundColor = colorBackground
        fourthPage.bodyLabel.textColor = colorLabelBlue
        
        fifth.view.backgroundColor = colorBackground
        fifth.bodyLabel.textColor = colorLabelBlue
		
        sixth.view.backgroundColor = colorBackground
        sixth.bodyLabel.textColor = colorLabelBlue
        sixth.titleLabel.textColor = colorLabelBlue
        
        seventh.view.backgroundColor = colorBackground
        seventh.bodyLabel.textColor = colorLabelBlue
        seventh.titleLabel.textColor = colorLabelBlue
		seventh.actionButton.backgroundColor = .actionColor
        seventh.actionButton.layer.cornerRadius = 15
        seventh.actionButton.clipsToBounds = true
        
        onboardingVC = OnboardingViewController.onboard(withBackgroundImage: UIImage(named: "giga-banner"), contents: [firstPage, secondPage, thirdPage, fourthPage, fifth, sixth,seventh])
		
		onboardingVC.skipButton.setTitleColor(.actionColor, for: .normal)
        onboardingVC.shouldFadeTransitions = true
        onboardingVC.shouldMaskBackground = false
        onboardingVC.shouldBlurBackground = false
        onboardingVC.fadePageControlOnLastPage = true
		onboardingVC.pageControl.pageIndicatorTintColor = .lightGray
		onboardingVC.pageControl.currentPageIndicatorTintColor = .selectionColor
       // onboardingVC.skipButton.setTitleColor(UIColor.white, for: .normal)
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
        self.window?.rootViewController = rootViewController
    }
    func skip() {
        self.window?.rootViewController = rootViewController
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
