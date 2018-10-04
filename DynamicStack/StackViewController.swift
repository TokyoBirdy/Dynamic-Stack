//
//  StackViewController.swift
//  DynamicStack
//
//  Created by ceciliah on 9/14/18.
//  Copyright © 2018 Humlan. All rights reserved.
//

import UIKit

class StackViewController: UIViewController {

    let staticHeight: CGFloat = 340

    let topDistance: CGFloat = 60.0

    var containerView: UIView!
    var scrollView: UIScrollView!

    var bottomView:UIView!
    var stackView: UIStackView!
    var stackBackgroundView: UIView!
    var imageView:UIImageView!
    var titleLabel: UILabel!
    var txtView: UITextView!
    var shuffleButton: UIButton! {
        didSet {
            shuffleButton.removeFromSuperview()
            scrollView.addSubview(shuffleButton)
            print("shuffle height", shuffleButton.frame.height)
            shuffleButton.setContentHuggingPriority(.required, for: .vertical)
            shuffleButton.setContentCompressionResistancePriority(.required, for: .vertical)
            let defaultPositionConstraint = shuffleButton.centerYAnchor.constraint(equalTo: bottomView.topAnchor)
            defaultPositionConstraint.priority = .defaultHigh
            let extendedConstraints:[NSLayoutConstraint] = [
                shuffleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                shuffleButton.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
                defaultPositionConstraint,
            ]

            NSLayoutConstraint.activate(extendedConstraints)
        }
    }

    var startPoint: CGPoint = CGPoint(x: 0, y: 0)

    var headerHeightConstraint: NSLayoutConstraint!

    var topConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!

    var maskView:UIView!

    var offSet:CGPoint = .zero

    var button: UIButton! {
        didSet {
            button.removeFromSuperview()
            self.stackView.addArrangedSubview(button)
            print("height", button.frame.height)
            button.setContentHuggingPriority(.required, for: .vertical)
            button.setContentCompressionResistancePriority(.required, for: .vertical)
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
        //view.layer.mask  = CALayer()
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.cyan.withAlphaComponent(0.5)
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = true
        scrollView.contentInsetAdjustmentBehavior = .never

        self.view.addSubview(scrollView)
        containerView = UIView()
        containerView.accessibilityIdentifier = "container view"
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)

        containerView.clipsToBounds = true
        scrollView.addSubview(containerView)

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

        let image = UIColor.orange.image(CGSize(width: 128, height: 128))
        imageView = UIImageView(image: image)
        stackView.addArrangedSubview(imageView)
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

        bottomView = UIView()
        bottomView.accessibilityIdentifier = "bottom view"
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
        scrollView.addSubview(bottomView)

        setUpConstraints()


    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        view.layer.mask?.backgroundColor = UIColor.white.cgColor
//        view.layer.mask?.frame = view.bounds.divided(atDistance: 100, from: .minYEdge).remainder
//    }




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
//        headerHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: staticHeight)
//        headerHeightConstraint.priority = .required
//        constraints.append(headerHeightConstraint)

        topConstraint = containerView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        topConstraint.priority = .defaultHigh
        constraints.append(topConstraint)

        bottomConstraint = bottomView.topAnchor.constraint(equalTo: containerView.bottomAnchor)
        bottomConstraint.priority = .defaultHigh
        constraints.append(bottomConstraint)



        let originalConstraints:[NSLayoutConstraint] = [
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            containerView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor),
            containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: staticHeight),

            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: topDistance),
            stackView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            stackBackgroundView.topAnchor.constraint(equalTo: stackView.topAnchor),
            stackBackgroundView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            stackBackgroundView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            stackBackgroundView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),

            titleLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -60),
            txtView.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor, constant: -60),

            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            bottomView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            bottomView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bottomView.topAnchor.constraint(lessThanOrEqualTo:containerView.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant:800),
            bottomView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ]
        
        constraints.append(contentsOf:originalConstraints)
        NSLayoutConstraint.activate(constraints)
    }

    private func updateStackViewController(distance: CGFloat) {
       bottomConstraint.constant = -distance
    }
}


extension StackViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        offSet = scrollView.contentOffset
        updateStackViewController(distance:offSet.y)
    }
}

