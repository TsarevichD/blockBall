//
//  Font + Extension.swift


import Foundation
import UIKit

extension UIFont {
    
    enum CustomFonts: String {
        case inter = "Inter"
    }
    
    enum CustomFontStyle: String {
        case bold = "-Bold"
        case regular = "-Regular"
    }
    
    static func customFont(
        
        font: CustomFonts,
        style: CustomFontStyle,
        size: Int,
        isScaled: Bool = true) -> UIFont {
            
            let fontName: String = font.rawValue + style.rawValue
            
            guard let font = UIFont(name: fontName, size: CGFloat(size)) else {
                debugPrint("Font can't be loaded")
                return UIFont.systemFont(ofSize: CGFloat(size))
            }
            
            return isScaled ? UIFontMetrics.default.scaledFont(for: font) : font
        }
}
