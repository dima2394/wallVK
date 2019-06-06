//
//  Created by Dmitriy Verennik on 06/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import RealmSwift

extension Results {

    var array: [Element] {
        return Array(self)
    }
}
