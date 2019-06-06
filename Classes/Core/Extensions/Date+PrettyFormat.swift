//
//  Created by Dmitriy Verennik on 06/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import Foundation

extension Date {

    var stringDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM YYYY"
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
}
