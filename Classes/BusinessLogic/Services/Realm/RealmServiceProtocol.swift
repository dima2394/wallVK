//
//  Created by Dmitriy Verennik on 06/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import RealmSwift

protocol HasRealmService {
    var realmService: RealmServiceProtocol { get }
}

protocol RealmServiceProtocol: class {
    var realm: Realm { get }

    func observeWallItems(withHandler handler: @escaping (RealmCollectionChange<Results<WallRealmModel>>) -> Void) -> NotificationToken
}
