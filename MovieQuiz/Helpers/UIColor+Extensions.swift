import UIKit

extension UIColor {
//    use this syntax to add more custom color's names into UIColor, likes UIColor.ypBlack
    static var ypBlack: UIColor { UIColor(named: "YP Black") ?? UIColor.black }
    static var ypGray: UIColor { UIColor(named: "YP Gray") ?? UIColor.gray }
    static var ypGreen: UIColor { UIColor(named: "YP Green") ?? UIColor.green }
    static var ypRed: UIColor { UIColor(named: "YP Red") ?? UIColor.red }
    static var ypWhite: UIColor { UIColor(named: "YP White") ?? UIColor.white }
// opacity 60% of the the original color of the background or darkGray as alternative
    static var ypBackground: UIColor { UIColor(named: "YP Background") ?? UIColor.darkGray }
}
