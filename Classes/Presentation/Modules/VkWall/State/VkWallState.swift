//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import VKSdkFramework

final class VkWallState {

    let user: VKUser
    var wallItems: [WallRealmModel]

    init(user: VKUser, wallItems: [WallRealmModel] = []) {
        self.user = user
        self.wallItems = wallItems
    }
}
