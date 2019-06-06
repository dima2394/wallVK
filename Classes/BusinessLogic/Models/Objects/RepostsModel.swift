//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import ObjectMapper

final class RepostsModel: Mappable {
    var count: Int = 0
    var iRepostedIt: Bool = false

    required init?(map: Map) {}

    func mapping(map: Map) {
        count           <- map["count"]
        iRepostedIt     <- map["user_reposted"]
    }
}
