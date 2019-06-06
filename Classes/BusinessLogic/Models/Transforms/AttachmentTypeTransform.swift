//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import ObjectMapper

class AttachmentTypeTransform: TransformType {

    typealias JSON = Any
    typealias Object = AttachmentType

    func transformFromJSON(_ value: Any?) -> AttachmentType? {
        if let value = value as? String {
            if value == "photo" {
                return .photo
            } else {
                return .other
            }
        } else {
            return .other
        }
    }

    func transformToJSON(_ value: AttachmentType?) -> Any? {
        return nil
    }
}
