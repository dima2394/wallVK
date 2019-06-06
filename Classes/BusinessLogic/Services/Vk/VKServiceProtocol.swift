//
//  Created by Dmitriy Verennik on 06/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import VKSdkFramework
import RealmSwift

protocol HasVKService {
    var vkService: VKServiceProtocol { get }
}

protocol VKServiceProtocol: class {
    func fetchWall()
    func observeWallItems(withHandler handler: @escaping (RealmCollectionChange<Results<WallRealmModel>>) -> Void) -> NotificationToken
}
