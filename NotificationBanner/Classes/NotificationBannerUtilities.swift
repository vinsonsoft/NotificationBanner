/*

 The MIT License (MIT)
 Copyright (c) 2017-2018 Dalton Hinterscher

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
 ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 */

import UIKit

class NotificationBannerUtilities: NSObject {

    /// The window used to read safe area insets / orientation from.
    /// `UIApplication.shared.keyWindow` is deprecated and can be nil under the UIScene lifecycle
    /// (e.g. while the scene is not foreground active), which made the banner fall back to the
    /// non-notch spacing and render under the notch / Dynamic Island.
    class var sceneWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            let windowScenes = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
            let windows = windowScenes.flatMap { $0.windows }
            return windows.first { $0.isKeyWindow }
                ?? windows.first
                ?? UIApplication.shared.delegate?.window
                ?? UIApplication.shared.keyWindow
        }
        return UIApplication.shared.keyWindow
    }

    class func isPortraitOrientation() -> Bool {
        if #available(iOS 13.0, *), let windowScene = sceneWindow?.windowScene {
            return windowScene.interfaceOrientation.isPortrait
        }
        return UIApplication.shared.statusBarOrientation.isPortrait
    }

    class func isNotchFeaturedIPhone() -> Bool {
        if #available(iOS 11, *) {
            if sceneWindow?.safeAreaInsets.bottom ?? 0.0 > 0.0 {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }

    class func hasDynamicIsland() -> Bool {
        if #available(iOS 11, *) {
            if sceneWindow?.safeAreaInsets.top ?? 0.0 > 50.0 {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }

}
