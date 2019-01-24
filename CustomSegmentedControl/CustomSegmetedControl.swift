//
//  CustomSegmented.swift
//  ViewControllerConatiner
//
//  Created by Camila Campana on 23/01/19.
//  Copyright © 2019 Camila Campana. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSegmentedControl: UIControl {

    var buttons = [UIButton]()
    var selector: UIView!
    var selectedSegmentIndex = 0

    @IBInspectable var commaSeperatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }

    @IBInspectable var textColor: UIColor = UIColor(red: 0.79, green: 0.79, blue: 0.79, alpha: 1) {
        didSet {
            updateView()
        }
    }

    @IBInspectable var selectorColor: UIColor = UIColor(displayP3Red: 0.3, green: 0.68, blue: 1.0, alpha: 1.0) {
        didSet {
            updateView()
        }
    }

    @IBInspectable var selectorTextColor: UIColor = UIColor(displayP3Red: 0.3, green: 0.68, blue: 1.0, alpha: 1.0) {
        didSet {
            updateView()
        }
    }

    @IBInspectable var lineColor: UIColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 0.7) {
        didSet {
            updateView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }


    func updateView() {
        buttons.removeAll()

        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        let buttonTitles = commaSeperatedButtonTitles.components(separatedBy: ",")
        for buttonTitle in buttonTitles {

            let button = UIButton.init(type: .system)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
            button.setTitle(buttonTitle.uppercased(), for: .normal)
            button.setTitleColor(textColor, for: .normal)
            //button.
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }

        let firstButton = buttons[0]
        firstButton.setTitleColor(selectorTextColor, for: .normal)

        selector = UIView(frame: CGRect(x: 0, y: 40, width: 64, height: 3))
        selector.backgroundColor = selectorColor
        addSubview(selector)

        // Create a StackView
        let stackView = UIStackView.init(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 0.0
        addSubview(stackView)

        stackView.setPosition(topAnchor: self.topAnchor, bottomAnchor: self.bottomAnchor,
                              leadingAnchor: self.leadingAnchor, trailingAnchor: self.trailingAnchor)

        selector.translatesAutoresizingMaskIntoConstraints = false
        selector.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true


        let line = UIView.init(frame: .zero)
        line.backgroundColor = lineColor
        addSubview(line)
        line.setPosition(topAnchor: stackView.bottomAnchor, bottomAnchor: line.bottomAnchor,
                         leadingAnchor: self.leadingAnchor, trailingAnchor: self.trailingAnchor)
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    @objc func buttonTapped(button: UIButton) {
        for (buttonIndex,btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)

            if btn == button {
                let  selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex) +
                    ((self.frame.width / 2) / 2) - 32

                UIView.animate(withDuration: 0.2, animations: {
                    self.selector.frame.origin.x = selectorStartPosition
                })

                btn.setTitleColor(selectorTextColor, for: .normal)
                selectedSegmentIndex = buttonIndex
            }
        }

        sendActions(for: .valueChanged)
    }
}

extension UIView {
    func setPosition(topAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>,
                     bottomAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>,
                     leadingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,
                     trailingAnchor: NSLayoutAnchor<NSLayoutXAxisAnchor>) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
}
