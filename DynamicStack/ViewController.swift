//
//  ViewController.swift
//  DynamicStack
//
//  Created by ceciliah on 9/14/18.
//  Copyright © 2018 Humlan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var testButton: UIButton!

    var stackViewController: StackViewController!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        testButton = UIButton(type: UIButtonType.custom)
        testButton.translatesAutoresizingMaskIntoConstraints = false
        testButton.setTitle("click me", for: .normal)
        testButton.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        testButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        super.viewDidLoad()
        self.view.addSubview(testButton)
        self.view.backgroundColor = UIColor.blue.withAlphaComponent(0.5)

        setupConstraints()

        stackViewController = StackViewController()
        _ = stackViewController.view


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    private func setupConstraints() {
        let constraints = [
            testButton.widthAnchor.constraint(equalToConstant: 100),
            testButton.heightAnchor.constraint(equalToConstant: 44),
            testButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            testButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    @objc func tapped() {

        stackViewController.titleLabel.text = "I am text"

        applyLabelStyle()

        stackViewController.txtView.text = "I am text view"

        applyTxtViewStyle()

        let customButton = UIButton(type: .custom)
        customButton.translatesAutoresizingMaskIntoConstraints = false
        customButton.setTitle("I am new", for: .normal)
        customButton.addTarget(self, action: #selector(stackButtonTapped), for: .touchUpInside)
        applyButtonStyle(with: customButton)
        stackViewController.button = customButton

        let shuffleButton = UIButton(type: .custom)
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        shuffleButton.setTitle("Shuffle play", for: .normal)
        shuffleButton.addTarget(self, action: #selector(shuffleButtonTapped), for: .touchUpInside)
        applyButtonStyle(with: shuffleButton)
        stackViewController.shuffleButton = shuffleButton

        self.navigationController?.pushViewController(stackViewController, animated: true)

    }


    private func applyLabelStyle() {

    }

    private func applyTxtViewStyle() {

    }

    private func applyButtonStyle(with button: UIButton) {
        button.frame.size.height = 48
        print("button frame", button.frame)
        button.backgroundColor = UIColor.green
    }

    @objc func stackButtonTapped() {
        print("me tapped")
    }

    @objc func shuffleButtonTapped() {
        print("shuffle me")
    }

}
