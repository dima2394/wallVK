//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import ObjectMapper

final class PhotoModel: Mappable {
    var id: Int = 0
    var url: String = ""
    var width: Int = 0
    var height: Int = 0
    var date: Date!
    var text: String = ""

    required init?(map: Map) {}

    func mapping(map: Map) {
        id         <- map["id"]
        url        <- map["photo_1280"]
        width      <- map["width"]
        height     <- map["height"]
        date       <- (map["date"], DateTransform())
        text       <- map["text"]
    }
}
