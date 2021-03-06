import Intents
import CoreData

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        if intent is SetBedTempIntent {
            return SetBedTempIntentHandler(printerManager: IntentHandler.printerManager)
        } else if intent is SetToolTempIntent {
            return SetToolTempIntentHandler(printerManager: IntentHandler.printerManager)
        } else if intent is SetChamberTempIntent {
            return SetChamberTempIntentHandler(printerManager: IntentHandler.printerManager)
        } else if intent is PauseJobIntent {
            return PauseJobIntentHandler(printerManager: IntentHandler.printerManager)
        } else if intent is ResumeJobIntent {
            return ResumeJobIntentHandler(printerManager: IntentHandler.printerManager)
        } else if intent is CancelJobIntent {
            return CancelJobIntentHandler(printerManager: IntentHandler.printerManager)
        } else if intent is RestartJobIntent {
            return RestartJobIntentHandler(printerManager: IntentHandler.printerManager)
        } else if intent is RemainingTimeIntent {
            return RemainingTimeIntentHandler(printerManager: IntentHandler.printerManager)
        } else if intent is CoolDownPrinterIntent {
            return CoolDownPrinterIntentHandler(printerManager: IntentHandler.printerManager)
        } else if intent is PaletteConnectIntent {
            return PaletteConnectIntentHandler(printerManager: IntentHandler.printerManager)
        } else if intent is PaletteDisconnectIntent {
            return PaletteDisconnectIntentHandler(printerManager: IntentHandler.printerManager)
        } else if intent is PaletteClearIntent {
            return PaletteClearIntentHandler(printerManager: IntentHandler.printerManager)
        } else if intent is PaletteCutIntent {
            return PaletteCutIntentHandler(printerManager: IntentHandler.printerManager)
        } else if intent is PalettePingStatsIntent {
            return PalettePingStatsIntentHandler(printerManager: IntentHandler.printerManager)
        } else if intent is SystemCommandIntent {
            return SystemCommandIntentHandler(printerManager: IntentHandler.printerManager)
        } else if intent is WidgetConfigurationIntent {
            if #available(iOSApplicationExtension 14.0, *) {
                return WidgetConfigurationIntentHandler(printerManager: IntentHandler.printerManager)
            } else {
                // Fallback on earlier versions
                fatalError("WidgetConfigurationIntent is only available on iOS 14 or newer")
            }
        } else if intent is DashboardWidgetConfigurationIntent {
            if #available(iOSApplicationExtension 14.0, *) {
                return DashboardWidgetConfigurationIntentHandler(printerManager: IntentHandler.printerManager)
            } else {
                // Fallback on earlier versions
                fatalError("WidgetConfigurationIntent is only available on iOS 14 or newer")
            }
        } else {
            fatalError("Unhandled intent type: \(intent)")
        }
    }
    
    // MARK: - Lazy variables

    /// Use static to return same instance to prevent app crash with core data when iOS creates multiple instances of this class
    static var persistentContainer: SharedPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = SharedPersistentContainer(name: "OctoPod")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    /// Use static to return same instance to prevent app crash with core data when iOS creates multiple instances of this class
    static var printerManager: PrinterManager = {
        let context = persistentContainer.viewContext
        var printerManager = PrinterManager()
        printerManager.managedObjectContext = context
        return printerManager
    }()

}
