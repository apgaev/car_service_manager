//
//  AlertControllerExtension.swift
//  car_service_manager
//
//  Created by Anton Gaev on 22.01.2020.
//  Copyright © 2020 Anton Gaev. All rights reserved.
//

import UIKit

extension UIAlertController {
    func addImage(image: UIImage) {
        let imgAction = UIAlertAction(title: "", style: .default, handler: nil)
        imgAction.isEnabled = true
        imgAction.setValue(image.withRenderingMode(.alwaysOriginal), forKey: "image")
        self.addAction(imgAction)
    }
    
    struct Holder {
            static var _alertImage = UIImageView()
    }
    var alertImage:UIImageView {
            get {
                return Holder._alertImage
            }
            set(newValue) {
                Holder._alertImage = newValue
            }
    }
}
