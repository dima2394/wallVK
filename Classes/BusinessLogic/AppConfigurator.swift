//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import UIKit


final class AppConfigurator {

    static func configure(_ application: UIApplication, with launchOptions: LaunchOptions?) {
        let appVersion = "\(Bundle.main.appVersion) (\(Bundle.main.bundleVersion))"
        UserDefaults.standard.appVersion = appVersion
    }
}

private extension UserDefaults {

    var appVersion: String? {
        get {
            return string(forKey: #function)
        }
        set {
            set(newValue, forKey: #function)
        }
    }
}
