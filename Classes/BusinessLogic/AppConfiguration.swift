//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import Foundation

enum AppConfiguration {

    private enum Paths {
        static let api = "api/"
        static let terms = "terms/"
    }

    private static let devServerURL = URL(string: "<#https://api.example.com/#>")!
    private static let prodServerURL = URL(string: "<#https://api.example.com/#>")!

    #if DEBUG_DEVELOPMENT

    static let serverURL = devServerURL
    static let baseURL = devServerURL.appendingPathComponent(Paths.api)
    static let termsURL = devServerURL.appendingPathComponent(Paths.terms)
    static let isNotificationsSandbox = true

    #elseif DEBUG_PRODUCTION

    static let serverURL = prodServerURL
    static let baseURL = prodServerURL.appendingPathComponent(Paths.api)
    static let termsURL = prodServerURL.appendingPathComponent(Paths.terms)
    static let isNotificationsSandbox = true

    #elseif ADHOC_DEVELOPMENT

    static let serverURL = devServerURL
    static let baseURL = devServerURL.appendingPathComponent(Paths.api)
    static let termsURL = devServerURL.appendingPathComponent(Paths.terms)
    static let isNotificationsSandbox = false

    #elseif ADHOC

    static let serverURL = prodServerURL
    static let baseURL = prodServerURL.appendingPathComponent(Paths.api)
    static let termsURL = prodServerURL.appendingPathComponent(Paths.terms)
    static let isNotificationsSandbox = false

    #elseif APPSTORE

    static let serverURL = prodServerURL
    static let baseURL = prodServerURL.appendingPathComponent(Paths.api)
    static let termsURL = prodServerURL.appendingPathComponent(Paths.terms)
    static let isNotificationsSandbox = false

    #elseif ANALYZE

    static let serverURL = devServerURL
    static let baseURL = devServerURL.appendingPathComponent(Paths.api)
    static let termsURL = devServerURL.appendingPathComponent(Paths.terms)
    static let isNotificationsSandbox = true

    #endif

    // MARK: - Checking for release

    #if !APPSTORE

    static let isRelease = false

    #else

    static let isRelease = true

    #endif
}
