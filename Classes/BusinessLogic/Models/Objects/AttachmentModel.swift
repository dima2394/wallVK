//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import ObjectMapper

enum AttachmentType {
    case photo, other
}

final class AttachmentModel: Mappable {
    var type: AttachmentType = .photo
    var photo: PhotoModel?

    required init?(map: Map) {}

    func mapping(map: Map) {
        type    <- (map["type"], AttachmentTypeTransform())
        photo   <- map["photo"]
    }
}
