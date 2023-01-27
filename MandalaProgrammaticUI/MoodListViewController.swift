//
//  MoodListViewController.swift
//  MandalaProgrammaticUI
//
//  Created by George Mapaya on 2023-01-26.
//

import UIKit
import SwiftUI

class MoodListViewController: UITableViewController, MoodsConfigurable {
    
    // MARK: - Data stores
    
    var moodEntries = [MoodEntry]()
    
    // MARK: Formatters
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = .autoupdatingCurrent
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(tableView)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moodEntries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let moodEntry = moodEntries[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UITableViewCell")
        var configuration = cell.defaultContentConfiguration()
        configuration.text = "I was \(moodEntry.mood.name)"
        configuration.image = moodEntry.mood.image
        configuration.imageProperties.maximumSize.width = 40
        configuration.imageProperties.maximumSize.height = 40
        configuration.secondaryText = dateFormatter.string(from: moodEntry.timestamp)
        cell.contentConfiguration = configuration
        return cell
    }
    
    // MARK: -  MoodsConfigurable protocol methods
    
    func add(_ moodEntry: MoodEntry) {
        moodEntries.insert(moodEntry, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    
}

// MARK: - Extension mood list view controller

extension MoodListViewController {
    
    // MARK: - Configure table view
    fileprivate func configure(_ tableView: UITableView) {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
    }
    
    
}

// MARK: - Previews using SwiftUI

/*
struct MoodListVCRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = MoodListViewController
    
    func makeUIViewController(context: Context) -> MoodListViewController {
        return MoodListViewController()
    }
    
    func updateUIViewController(_ uiViewController: MoodListViewController, context: Context) {
        
    }
}

struct MoodListVCRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        return MoodListVCRepresentable()
    }
}
*/
