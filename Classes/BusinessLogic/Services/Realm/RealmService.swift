//
//  Created by Dmitriy Verennik on 06/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmService: RealmServiceProtocol {

    var realm: Realm

    init() {
        do {
            let config = Realm.Configuration.defaultConfiguration
            realm = try Realm(configuration: config)
        } catch {
            fatalError("can't instance realm")
        }
    }

    func observeWallItems(withHandler handler: @escaping (RealmCollectionChange<Results<WallRealmModel>>) -> Void) -> NotificationToken {
        return realm.objects(WallRealmModel.self).sorted(byKeyPath: "date", ascending: false).observe(handler)
    }
}
