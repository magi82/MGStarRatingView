//
//  StarRatingView+RTLSupport.swift
//  MGStarRatingView
//
//  Created by AmrAngry on 2/5/21.
//  Copyright © 2021 magi. All rights reserved.
//

import Foundation

extension StarRatingView {
    
    /// Flip the View to support Right to Left Languages based on the view semantic
    func flipViewIfNeeded() {
        var direction: UIUserInterfaceLayoutDirection
        if #available(iOS 10.0, *) {
            direction = self.effectiveUserInterfaceLayoutDirection
        } else { // Fallback on earlier versions
            if #available(iOS 9.0, *) {
                // The view is shown in right-to-left mode right now.
                direction = UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute)
            } else { // Fallback on earlier versions
                direction = UIApplication.shared.userInterfaceLayoutDirection
            }
        }
        
        if case .rightToLeft = direction {
            flip()
        }
    }
    
    private func flip() {
        self.transform = CGAffineTransform(scaleX: -1.0, y: 1.0);
    }
    
}
