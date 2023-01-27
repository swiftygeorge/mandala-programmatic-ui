//
//  Mood.swift
//  MandalaProgrammaticUI
//
//  Created by George Mapaya on 2023-01-26.
//

import UIKit

struct Mood {
    var name: String
    var image: UIImage
    var color: UIColor
}

extension Mood {
    
    static let angry = Mood(name: "angry", image: UIImage(resource: .angry), color: .angry)
    static let confused = Mood(name: "confused", image: UIImage(resource: .confused), color: .confused)
    static let crying = Mood(name: "crying", image: UIImage(resource: .crying), color: .crying)
    static let goofy = Mood(name: "goofy", image: UIImage(resource: .goofy), color: .goofy)
    static let happy = Mood(name: "happy", image: UIImage(resource: .happy), color: .happy)
    static let meh = Mood(name: "meh", image: UIImage(resource: .meh), color: .meh)
    static let sad = Mood(name: "sad", image: UIImage(resource: .sad), color: .sad)
    static let sleepy = Mood(name: "sleepy", image: UIImage(resource: .sleepy), color: .sleepy)
    
    
}
