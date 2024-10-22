//
//  Double + Extension.swift

import UIKit

extension Double {
    var autoSize: CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let statusBarOrientation = windowScene.interfaceOrientation
            let screenSize = UIScreen.main.bounds.size
            let referenceSizeHeight: CGFloat = 852
            let referenceSizeWidth: CGFloat = 393 // Минимальная ширина для учёта

            let screenSizeOrientationHeight = statusBarOrientation.isPortrait ? screenSize.height : screenSize.width
            let screenSizeOrientationWidth = statusBarOrientation.isPortrait ? screenSize.width : screenSize.height

            let maxAspectRatioHeight = screenSizeOrientationHeight / referenceSizeHeight
            let maxAspectRatioWidth = screenSizeOrientationWidth / referenceSizeWidth
            
            let maxAspectRatio = min(maxAspectRatioHeight, maxAspectRatioWidth)
            
            return CGFloat(self) * maxAspectRatio // Приведение типа и применение наименьшего соотношения
        }
        return CGFloat(self) // Приведение типа
    }
}

