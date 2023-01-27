//
//  UIImage+Mandala.swift
//  MandalaProgrammaticUI
//
//  Created by George Mapaya on 2023-01-26.
//

import UIKit

enum ImageResource: String {
    case angry
    case confused
    case crying
    case goofy
    case happy
    case meh
    case sad
    case sleepy
}

extension UIImage {
    
    convenience init(resource: ImageResource) {
        self.init(named: resource.rawValue)!
    }
    
    
}
