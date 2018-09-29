//
//  UIView+constraints.swift
//  Watermelon
//
//  Created by Gleb Shendrik on 27/09/2018.
//  Copyright © 2018 Gleb Shendrik. All rights reserved.
//

import UIKit

extension UIView {
    func pinEdges(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28).isActive = true
    }
}
