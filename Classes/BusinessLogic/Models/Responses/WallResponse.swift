//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import ObjectMapper

class WallResponse: Mappable {
    var count: Int = 0
    var wallItems: [WallModel] = []

    required init?(map: Map) {}

    func mapping(map: Map) {
        count       <- map["count"]
        wallItems   <- map["items"]
    }
}
