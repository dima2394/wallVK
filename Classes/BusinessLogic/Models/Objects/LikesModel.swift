//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import ObjectMapper

final class LikesModel: Mappable {
    var count: Int = 0
    var iLikedIt: Bool = false
    
    required init?(map: Map) {}

    func mapping(map: Map) {
        count       <- map["count"]
        iLikedIt    <- map["user_likes"]
    }
}
