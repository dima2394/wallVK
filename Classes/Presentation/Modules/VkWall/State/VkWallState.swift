//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import VKSdkFramework

final class VkWallState {

    var wallItems: [WallRealmModel]

    init(wallItems: [WallRealmModel] = []) {
        self.wallItems = wallItems
    }
}
