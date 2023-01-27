//
//  MoodsConfigurable.swift
//  MandalaProgrammaticUI
//
//  Created by George Mapaya on 2023-01-27.
//

import Foundation

/// Gives any view controller that conforms to it the ability do add a mood entry
protocol MoodsConfigurable {
    func add(_ moodEntry: MoodEntry)
}
