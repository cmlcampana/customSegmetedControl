//
//  ViewController.swift
//  ViewControllerConatiner
//
//  Created by Camila Campana on 23/01/19.
//  Copyright © 2019 Camila Campana. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    var segmentedControl: CustomSegmentedControl!
    @IBOutlet weak var mainView: UIView!

    private lazy var summaryViewController: SummaryViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SummaryViewController") as! SummaryViewController

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()

    private lazy var sessionsViewController: SessionViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SessionViewController") as! SessionViewController

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        setupView()
    }

    private func setupView() {
        setupSegmentedControl()

        //updateView()
    }

    private func setupSegmentedControl() {
        segmentedControl = CustomSegmentedControl(frame: .zero, width: self.view.frame.width)

        segmentedControl.backgroundColor = .white
        segmentedControl.commaSeperatedButtonTitles = "Meus Produtos, Visita Técnica"
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0

        self.view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true

        updateView()
    }

    private func add(asChildViewController viewController: UIViewController) {

        // Add Child View as Subview
        mainView.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = mainView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }

    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: self)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParent()
    }

    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }

    func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: sessionsViewController)
            add(asChildViewController: summaryViewController)
        } else {
            remove(asChildViewController: summaryViewController)
            add(asChildViewController: sessionsViewController)
        }
    }
}

