//
//  StackViewController.swift
//  DynamicStack
//
//  Created by ceciliah on 9/14/18.
//  Copyright © 2018 Humlan. All rights reserved.
//

import UIKit

class StackViewController: UIViewController {

    let staticHeight: CGFloat = 300.0

    let topDistance: CGFloat = 100.0

    var containerView: UIView!
    var scrollView: UIScrollView!

    var stackView: UIStackView!
    var stackBackgroundView: UIView!
    var titleLabel: UILabel!
    var txtView: UITextView!

    var startPoint: CGPoint = CGPoint(x: 0, y: 0)

    var headerHeightConstraint: NSLayoutConstraint!

    var button: UIButton! {
        didSet {
            button.removeFromSuperview()
            self.stackView .addArrangedSubview(button)
            print("height", button.frame.height)
            let extendedConstraints = [

                button.heightAnchor.constraint(equalToConstant: button.frame.height)
                ]
            constraints.append(contentsOf: extendedConstraints)
            NSLayoutConstraint.activate(constraints)

        }
    }

    var constraints = [NSLayoutConstraint]()

    init() {
        super.init(nibName: nil, bundle: nil)

    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }


    override func viewDidLoad() {
        containerView = UIView()
        containerView.accessibilityIdentifier = "container view"
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)

        containerView.clipsToBounds = true
        view.addSubview(containerView)

        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.setContentHuggingPriority(.required, for: .vertical)
        containerView .addSubview(stackView)




        stackBackgroundView = UIView()
        stackBackgroundView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        stackBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        stackView.insertSubview(stackBackgroundView, at: 0)


        //Label has a max width, and a certain font, if it exceeds the length adjust font
        titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        applyDefaultLabelStyle()
        stackView.addArrangedSubview(titleLabel)


        txtView = UITextView(frame: .zero)
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.setContentHuggingPriority(.required, for: .vertical)
        applyDefaultTxtViewStyle()
        stackView.addArrangedSubview(txtView)

        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.cyan.withAlphaComponent(0.5)
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 1000)
        scrollView.showsVerticalScrollIndicator = true
        scrollView.contentInsetAdjustmentBehavior = .never

        self.view.addSubview(scrollView)

        setUpConstraints()


    }


    private func applyDefaultLabelStyle() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = UIColor.green
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.isUserInteractionEnabled = false
    }

    private func applyDefaultTxtViewStyle() {
        txtView.font = UIFont.boldSystemFont(ofSize: 10)
        txtView.textColor = UIColor.black.withAlphaComponent(0.5)
        txtView.adjustsFontForContentSizeCategory = true
        txtView.textAlignment = .center
        txtView.isScrollEnabled = false
        txtView.isEditable = false
    }


    private func setUpConstraints () {
        headerHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: staticHeight)
        headerHeightConstraint.priority = .defaultHigh
        constraints.append(headerHeightConstraint)

        let originalConstraints = [
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: topDistance),

            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: topDistance),
            stackView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            stackBackgroundView.topAnchor.constraint(equalTo: stackView.topAnchor),
            stackBackgroundView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            stackBackgroundView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            stackBackgroundView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),

            titleLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -60),
            txtView.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor, constant: -60),

            scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ]
        constraints.append(contentsOf:originalConstraints)
        NSLayoutConstraint.activate(constraints)
    }



    private func updateStackViewController(distance: CGFloat) {
        let adjusted = staticHeight - distance
        
        headerHeightConstraint.constant = max(adjusted, topDistance)

       // self.view.layoutIfNeeded()
    }




}


extension StackViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset

        print("scroll view offset", offset)
        updateStackViewController(distance:offset.y)
    }
}
