//
//  MoodSelectionViewController.swift
//  MandalaProgrammaticUI
//
//  Created by George Mapaya on 2023-01-26.
//

import UIKit
import SwiftUI

class MoodSelectionViewController: UIViewController {
    
    // MARK: - View objects
    
    let visualEffectView = UIVisualEffectView()
    
    let stackView = UIStackView()
    
    let moodSelector: ImageSelector = {
        let imageSelector = ImageSelector()
        imageSelector.addTarget(nil, action: #selector(moodSelectionChanged(_:)), for: .valueChanged)
        imageSelector.translatesAutoresizingMaskIntoConstraints = false
        return imageSelector
    }()
    
    let addMoodButton = UIButton(type: .system)
    
    let moodListViewController = MoodListViewController()
    
    // MARK: - Data stores
    
    var moodsConfigurable: MoodsConfigurable!
    var moods = [Mood]() {
        didSet {
            currentMood = moods.first
            moodSelector.images = moods.map { $0.image }
        }
    }
    var currentMood: Mood? {
        didSet {
            guard let currentMood = currentMood else {
                addMoodButton.setTitle(nil, for: .normal)
                addMoodButton.backgroundColor = nil
                return
            }
            addMoodButton.setTitle("I'm feeling \(currentMood.name)", for: .normal)
            addMoodButton.backgroundColor = currentMood.color
        }
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addMoodButton.layer.cornerRadius = addMoodButton.bounds.height / 2
    }
    
    // MARK: - Actions
    
    /// Triggered when a user taps on one of the mood buttons
    /// - Parameter sender: the button that was tapped (must conform to UIButton)
    @objc func moodSelectionChanged(_ sender: ImageSelector) {
        let selectedIndex = sender.selectedIndex
        currentMood = moods[selectedIndex]
    }
    
    /// Triggered when the user taps the addMoodButton.
    /// Creates a new mood entry and adds it to the list of mood entries in moodsConfigurable
    /// - Parameter sender: Any
    @objc func addMoodTapped(_ sender: Any) {
        guard let currentMood = currentMood else { return }
        let newMoodEntry = MoodEntry(mood: currentMood, timestamp: Date())
        moodsConfigurable.add(newMoodEntry)
    }
    
    // MARK: - Methods
    
    ///  Sets the respective view object's translatesAutoresizingMaskIntoConstraints to false
    ///  Helps avoid auto layout issues
    /// - Parameter view: a view that conforms to UIView
    private func tamic(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Sets up all the views in the view hierarchy when the view is initially loaded
    private func setup() {
        self.view.backgroundColor = .systemBackground
        self.moodsConfigurable = moodListViewController
        configure(visualEffectView)
        configure(moodSelector)
        configure(addMoodButton)
        configure(moodListViewController)
        moods = [.happy, .sad, .angry, .goofy, .crying, .confused, .sleepy, .meh]
    }
    
    
}

// MARK: - Extension Mood selection view controller

extension MoodSelectionViewController {
    
    // MARK: Configure visual effect view
    
    /// Performs initial setup for the visual effect view
    /// Adds the visual effect view as a subview of the main view
    /// Adds constraints to the visual effect view
    /// - Parameter visualEffectView: a view that conforms to the UIVisualEffectView
    fileprivate func configure(_ visualEffectView: UIVisualEffectView) {
        visualEffectView.effect = UIBlurEffect(style: .regular)
        tamic(visualEffectView)
        self.view.addSubview(visualEffectView)
        NSLayoutConstraint.activate([
            visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // TODO: - Find out why the visual effect view is not stretching all the way to the bottom of the screen
            visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: Configure stack view
    
    /// Performs initial setup for the stack view that holds the mood selection buttons
    /// Sets the stack view's axis, spacing, distribution and alignment
    /// Adds the stackView to the visual effect view's content view's subviews
    /// Constrains the stack view to the visual effect view's content view (respecting the content view's margins)
    /// - Parameter stackView: a view that conforms to the UIStackView type
    fileprivate func configure(_ imageSelector: ImageSelector) {
        self.visualEffectView.contentView.addSubview(moodSelector)
        let margins = visualEffectView.contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            moodSelector.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            moodSelector.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            moodSelector.topAnchor.constraint(equalTo: margins.topAnchor, constant: 8),
            moodSelector.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            moodSelector.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: Configure add mood button
    
    /// Performs initial setup for the add mood button
    /// Sets the button's title, title color, background color and target
    /// Adds the button to the main view's subviews
    /// Constrains the button
    /// - Parameter button: a view that conforms to the UIButton type
    fileprivate func configure(_ button: UIButton) {
        button.setTitle("Add Mood", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .secondarySystemFill
        button.addTarget(self, action: #selector(addMoodTapped(_:)), for: .touchUpInside)
        tamic(button)
        view.addSubview(button)
        let marginsFrame = view.layoutMarginsGuide.layoutFrame
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: visualEffectView.topAnchor, constant: -20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: marginsFrame.width / 2),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    // MARK: - Configure mood list view controller
    
    /// Performs initial setup for the mood list view controller
    /// Adds mood list view controller as a child of main view controller
    /// Inserts additional safe area at the bottom of mood list view controller to carter for the mood buttons control
    /// Sest mood list view controller's view frame to be same size as the main view's frame
    /// Inserts the mood list view controller's view as the first view in the main view's subviews
    /// Calls the didMove method of mood list view controller after transition to mood selection view controller is complete
    /// - Parameter tableViewController: a view that conforms to the UITableViewController type
    fileprivate func configure(_ tableViewController: UITableViewController) {
        moodListViewController.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)
        self.addChild(moodListViewController)
        moodListViewController.view.frame = self.view.frame
        view.insertSubview(moodListViewController.view, at: 0)
        moodListViewController.didMove(toParent: self)
    }
    
    
}

// MARK: - Previews using SwiftUI

/// Makes it possible to preview MoodSelectionViewController using SwiftUI previews in the canvas
struct MoodSelectionVCRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = MoodSelectionViewController
    
    func makeUIViewController(context: Context) -> MoodSelectionViewController {
        return MoodSelectionViewController()
    }
    
    func updateUIViewController(_ uiViewController: MoodSelectionViewController, context: Context) {
        
    }
    
}

/// Creates a SwiftUI preview of MoodSelectionViewController
struct MoodSelectionVCRepresentable_Previews: PreviewProvider {
    
    static var previews: some View {
        return MoodSelectionVCRepresentable()
    }
    
}
