//
//  Created by Dmitriy Verennik on 05/06/2019
//  Copyright © 2019 dverennik. All rights reserved.
//

import UIKit
import Framezilla

extension UIView {

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(self.addSubview)
    }
}
