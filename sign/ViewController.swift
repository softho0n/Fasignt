//
//  ViewController.swift
//  sign
//
//  Created by Jason on 2022/02/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    private lazy var firstViewController: FirstViewController = {
            // Load Storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

            // Instantiate View Controller
            var viewController = storyboard.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController

            // Add View Controller as Child View Controller
            self.addChild(viewController)
            return viewController
        }()
    
    private lazy var secondViewController: SecondViewController = {
            // Load Storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

            // Instantiate View Controller
            var viewController = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController

            // Add View Controller as Child View Controller
            self.addChild(viewController)
            return viewController
        }()
    
    static func viewController() -> ViewController {
            return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        }
    
    private func add(asChildViewController viewController: UIViewController) {

            // Add Child View Controller
            addChild(viewController)

            // Add Child View as Subview
            containerView.addSubview(viewController.view)

            // Configure Child View
            viewController.view.frame = containerView.bounds
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            // Notify Child View Controller
            viewController.didMove(toParent: self)
        }
    
    private func remove(asChildViewController viewController: UIViewController) {
            // Notify Child View Controller
            viewController.willMove(toParent: nil)

            // Remove Child View From Superview
            viewController.view.removeFromSuperview()

            // Notify Child View Controller
            viewController.removeFromParent()
        }
    
    private func updateView() {
            if segmentedControl.selectedSegmentIndex == 0 {
                remove(asChildViewController: secondViewController)
                add(asChildViewController: firstViewController)
            } else {
                remove(asChildViewController: firstViewController)
                add(asChildViewController: secondViewController)
            }
        }
    
    func setupView() {
            updateView()
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func control(_ sender: Any) {
        updateView()
    }
}

