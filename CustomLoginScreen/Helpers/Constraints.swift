//
//  Constraints.swift
//  CustomLoginScreen
//
//  Created by Satish Boggarapu on 2/20/18.
//  Copyright © 2018 Satish Boggarapu. All rights reserved.
//

import Foundation
import UIKit

public class Constraints {
    static public func getLoginScreenNameViewY(iconView: CGRect, view: CGRect) -> CGFloat {
        switch ScreenType.screenType {
        case .iPhoneSE_1136?:
            return iconView.origin.y + iconView.height + 30
        default:
            return view.height * 0.45
        }
    }
    
    static public func getLoginScreenSignInButtonY(passwordView: CGRect) -> CGFloat {
        let y: CGFloat = passwordView.origin.y + passwordView.height
        switch ScreenType.screenType {
        case .iPhoneSE_1136?:
            return y + 35
        case .iPhoneX_2436?:
            return y + 60
        default:
            return y + 50
        }
    }
    
    static public func getLoginScreenSignUpButtonY(view: CGRect) -> CGFloat {
        let y: CGFloat = view.height*0.55
        switch ScreenType.screenType {
        case .iPhoneX_2436?:
            return y - 80
        default:
            return y - 50
        }
    }
}
