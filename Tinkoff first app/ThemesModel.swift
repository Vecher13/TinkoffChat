//
//  ThemesModel.swift
//  Tinkoff first app
//
//  Created by Ash on 09.03.2021.
//

import Foundation
import UIKit


protocol Theme13 {
var backgroundColor : UIColor { get }
var secondaryBackgroundColor : UIColor {get}
var labelTextColor: UIColor {get}
var subLabelTextColor: UIColor {get}
var inBabbleColor: UIColor {get}
var outBabbleColor: UIColor {get}
var heading : UIColor {get}
var subHeading : UIColor {get}
var sepratorColor : UIColor { get }
var tintColor : UIColor { get }
    var buttonBackgroundColor: UIColor {get}
    var barStyle: UIBarStyle {get}
//    func apply(for application: UIApplication)
}
extension Theme13 {
    func applayAppearance(for application: UIApplication){
        UITableView.appearance().backgroundColor = backgroundColor
        UITableView.appearance().backgroundView?.backgroundColor = backgroundColor
        UITableView.appearance().tableHeaderView?.backgroundColor = backgroundColor
        let tabBarProxy = UITabBar.appearance()
        tabBarProxy.barStyle = barStyle
        tabBarProxy.backgroundColor = backgroundColor
        UINavigationBar.appearance().barStyle = barStyle
        
        
        application.windows.reload()
    }
}

struct ClassicTheme : Theme13 {
    var buttonBackgroundColor: UIColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
    
var inBabbleColor: UIColor = #colorLiteral(red: 0.8745098039, green: 0.8745098039, blue: 0.8745098039, alpha: 1)
var outBabbleColor: UIColor = #colorLiteral(red: 0.862745098, green: 0.968627451, blue: 0.7725490196, alpha: 1)
var subLabelTextColor: UIColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 1)
    var labelTextColor: UIColor = .black
var backgroundColor: UIColor = UIColor.white
var secondaryBackgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
var heading: UIColor = UIColor.white
var subHeading: UIColor = UIColor.gray
var sepratorColor: UIColor = UIColor.green
var tintColor: UIColor = UIColor.blue
    var barStyle: UIBarStyle = .default
}
struct NightTheme : Theme13 {
    var buttonBackgroundColor: UIColor = #colorLiteral(red: 0.1058823529, green: 0.1058823529, blue: 0.1058823529, alpha: 1)
    
    
    var inBabbleColor: UIColor = #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
    
    var outBabbleColor: UIColor = #colorLiteral(red: 0.3607843137, green: 0.3607843137, blue: 0.3607843137, alpha: 1)
    
    var subLabelTextColor: UIColor = #colorLiteral(red: 0.5529411765, green: 0.5529411765, blue: 0.5764705882, alpha: 1)
    
    var labelTextColor: UIColor = .white
    
var backgroundColor = UIColor.black
var secondaryBackgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
var heading = UIColor.black
var subHeading = UIColor.purple
var sepratorColor: UIColor = UIColor.red
var tintColor: UIColor = UIColor.blue
    var barStyle: UIBarStyle = .black
  
}

struct DayTheme: Theme13 {
    var buttonBackgroundColor: UIColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
    
    var inBabbleColor: UIColor = #colorLiteral(red: 0.9176470588, green: 0.9215686275, blue: 0.9294117647, alpha: 1)
    
    var outBabbleColor: UIColor = #colorLiteral(red: 0.262745098, green: 0.537254902, blue: 0.9764705882, alpha: 1)
    
    var backgroundColor: UIColor = .white
    
    var secondaryBackgroundColor: UIColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
    
    var labelTextColor: UIColor = .black
    
    var subLabelTextColor: UIColor = #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.262745098, alpha: 1)
    
    var heading: UIColor = .white
    
    var subHeading: UIColor = #colorLiteral(red: 0.5529411765, green: 0.5529411765, blue: 0.5764705882, alpha: 1)
    
    var sepratorColor: UIColor = .gray
    
    var tintColor: UIColor = .blue
    
    var barStyle: UIBarStyle = .default
    
}
// ---!

class ThemesManager {
    var theme : Theme13?
    static var shared : ThemesManager = {
        let themeneManager  = ThemesManager()
        return themeneManager
    }()
    
    func setTheme(theme : Theme13){
        self.theme = theme
    }
    
 
}





// ---------!!------

protocol Theme12 {
    var tint: UIColor { get }
    var secondaryTint: UIColor { get }
    
    var backgroundColor: UIColor { get }
    var separatorColor: UIColor { get }
    var selectionColor: UIColor { get }
    
    var labelColor: UIColor { get }
    var secondaryLabelColor: UIColor { get }
    var subtleLabelColor: UIColor { get }
    
    var barStyle: UIBarStyle { get }
    
    func apply(for application: UIApplication)
    func extend()
}

extension Theme12 {
    
    func apply(for application: UIApplication) {
        application.keyWindow?.tintColor = tint
        
        UITabBar.appearance().with {
            $0.barStyle = barStyle
            $0.tintColor = tint
            $0.backgroundColor = .white
        }
        
        UINavigationBar.appearance().with {
            $0.barStyle = barStyle
            $0.tintColor = tint
            $0.titleTextAttributes = [
                .foregroundColor: labelColor
            ]
            
            if #available(iOS 11.0, *) {
                $0.largeTitleTextAttributes = [
                    .foregroundColor: labelColor
                ]
            }
        }
        
        UICollectionView.appearance().backgroundColor = backgroundColor
        
        UITableView.appearance().with {
            $0.backgroundColor = backgroundColor
            $0.separatorColor = separatorColor
        }
        
        UITableViewCell.appearance().with {
            $0.backgroundColor = .clear
//            $0.selectionColor = selectionColor
        }
        
        UIView.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
            .backgroundColor = selectionColor
        
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
            .textColor = secondaryLabelColor
        
       
        
        AppLabel.appearance().textColor = labelColor
        AppHeadline.appearance().textColor = secondaryTint
        AppSubhead.appearance().textColor = secondaryLabelColor
        AppFootnote.appearance().textColor = subtleLabelColor
        
        AppButton.appearance().with {
            $0.setTitleColor(tint, for: .normal)
//            $0.layer.borderColor = tint
//            $0.borderWidth = 1
//            $0.cornerRadius = 3
        }
        
        AppDangerButton.appearance().with {
            $0.setTitleColor(backgroundColor, for: .normal)
            $0.backgroundColor = tint
//            $0.cornerRadius = 3
        }
        
        AppSwitch.appearance().with {
            $0.tintColor = tint
            $0.onTintColor = tint
        }
        
//        AppStepper.appearance().tintColor = tint
//
//        AppSlider.appearance().tintColor = tint
//
//        AppSegmentedControl.appearance().tintColor = tint
        
        AppView.appearance().backgroundColor = backgroundColor
        
        AppSeparator.appearance().with {
            $0.backgroundColor = separatorColor
            $0.alpha = 0.5
        }
        
        AppView.appearance(whenContainedInInstancesOf: [AppView.self]).with {
            $0.backgroundColor = selectionColor
//            $0.cornerRadius = 10
        }
        
        // Style differently when inside a special container
        
        AppLabel.appearance(whenContainedInInstancesOf: [AppView.self, AppView.self]).textColor = subtleLabelColor
        AppHeadline.appearance(whenContainedInInstancesOf: [AppView.self, AppView.self]).textColor = secondaryLabelColor
        AppSubhead.appearance(whenContainedInInstancesOf: [AppView.self, AppView.self]).textColor = secondaryTint
        AppFootnote.appearance(whenContainedInInstancesOf: [AppView.self, AppView.self]).textColor = labelColor
        
        AppButton.appearance(whenContainedInInstancesOf: [AppView.self, AppView.self]).with {
            $0.setTitleColor(labelColor, for: .normal)
//            $0.borderColor = labelColor
        }
        
        AppDangerButton.appearance(whenContainedInInstancesOf: [AppView.self, AppView.self]).with {
            $0.setTitleColor(subtleLabelColor, for: .normal)
            $0.backgroundColor = labelColor
        }
        
        AppSwitch.appearance(whenContainedInInstancesOf: [AppView.self, AppView.self]).with {
            $0.tintColor = secondaryTint
            $0.onTintColor = secondaryTint
        }
        UITextView.appearance().textColor = .blue
        extend()
        
        // Ensure existing views render with new theme
        
        
        application.windows.reload()
    }
    
    func extend() {
        // Optionally extend theme
    }
}

struct DarkThemeOld: Theme12 {
    let tint: UIColor = .yellow
    let secondaryTint: UIColor = .green
    
    let backgroundColor: UIColor = .black
    let separatorColor: UIColor = .lightGray
    let selectionColor: UIColor = .init(red: 38/255, green: 38/255, blue: 40/255, alpha: 1)
    
    let labelColor: UIColor = .white
    let secondaryLabelColor: UIColor = .lightGray
    let subtleLabelColor: UIColor = .darkGray
    
    let barStyle: UIBarStyle = .black
}

struct LightThemeOld: Theme12 {
    let tint: UIColor = .blue
    let secondaryTint: UIColor = .orange
    
    let backgroundColor: UIColor = .white
    let separatorColor: UIColor = .lightGray
    let selectionColor: UIColor = .init(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
    
    let labelColor: UIColor = .black
    let secondaryLabelColor: UIColor = .darkGray
    let subtleLabelColor: UIColor = .lightGray
    
    let barStyle: UIBarStyle = .default
    let barColor: UIUserInterfaceStyle = .light
    
    
}

extension UITableViewCell {
    
    /// The color of the cell when it is selected.
    var selectionColor: UIColor? {
        get { return selectedBackgroundView?.backgroundColor }
        set {
            guard selectionStyle != .none else { return }
            selectedBackgroundView = UIView().with {
                $0.backgroundColor = newValue
            }
        }
    }
}


public extension UIWindow {
    
    /// Unload all views and add back.
    /// Useful for applying `UIAppearance` changes to existing views.
    func reload() {
        subviews.forEach { view in
            view.removeFromSuperview()
            addSubview(view)
        }
    }
}
public extension Array where Element == UIWindow {
    
    /// Unload all views for each `UIWindow` and add back.
    /// Useful for applying `UIAppearance` changes to existing views.
    func reload() {
        forEach { $0.reload() }
    }
}





struct oldTheme {

    static var backgroundColor:UIColor?
    static var buttonTextColor:UIColor?
    static var buttonBackgroundColor:UIColor?
    static var inBubbleColor: UIColor = .systemBlue
    static var outBubbleColor: UIColor = .systemGreen
    static var textColor: UIColor?
    static var subTitleColor: UIColor?
    
    static public func defaultTheme() {
        self.backgroundColor = UIColor.white
        self.buttonTextColor = UIColor.blue
        self.buttonBackgroundColor = UIColor.white
        updateDisplay()
    }

    static public func darkTheme() {
//        self.backgroundColor = UIColor.darkGray
        self.buttonTextColor = UIColor.white
//        self.buttonBackgroundColor = UIColor.black
        self.backgroundColor = .black
        self.inBubbleColor = #colorLiteral(red: 0.1803726554, green: 0.1804046035, blue: 0.1803657115, alpha: 1)
        self.outBubbleColor = #colorLiteral(red: 0.3607498705, green: 0.3608063161, blue: 0.3607375622, alpha: 1)
        self.textColor = .white
        self.subTitleColor = .gray
        
        updateDisplay()
    }
    
    static public func classicTheme() {
//        self.backgroundColor = UIColor.darkGray
        self.buttonTextColor = UIColor.white
//        self.buttonBackgroundColor = UIColor.black
        self.backgroundColor = .black
        self.inBubbleColor = #colorLiteral(red: 0.1803726554, green: 0.1804046035, blue: 0.1803657115, alpha: 1)
        self.outBubbleColor = #colorLiteral(red: 0.3607498705, green: 0.3608063161, blue: 0.3607375622, alpha: 1)
        self.textColor = .white
        self.subTitleColor = .gray
        
        updateDisplay()
    }
    

    static public func updateDisplay() {
        
//        UILabel.appearance(whenContainedInInstancesOf: [UITableView.self, UITableViewCell.self]).textColor = subTitleColor
//        UILabel.appearance(whenContainedInInstancesOf: [UIView.self, UIView.self]).textColor = .brown
//        UILabel.appearance(whenContainedInInstancesOf: [AppView.self, AppView.self]).textColor = subTitleColor
//
  
        
        AppLabel.appearance().textColor = .white
        SubLabel.appearance(whenContainedInInstancesOf: [UITableView.self]).textColor = subTitleColor

//        let proxyButton = UIButton.appearance()
//        proxyButton.setTitleColor(Theme.buttonTextColor, for: .normal)
//        proxyButton.backgroundColor = #colorLiteral(red: 0.01899982989, green: 0.01900083758, blue: 0.01900029555, alpha: 1)
     
        let custom = CustomView.appearance()
        custom.backgroundColor = backgroundColor
        
        
        let proxyTable = UITableView.appearance()
        proxyTable.backgroundColor = backgroundColor
//        proxyTable.reloadData()
        
        let cell = UICollectionViewCell.appearance()
        cell.contentView.backgroundColor = backgroundColor
        
        let proxyTableCell = UITableViewCell.appearance()
        proxyTableCell.contentView.tintColor = backgroundColor
        proxyTableCell.backgroundView?.backgroundColor = backgroundColor
        proxyTableCell.contentView.tintColorDidChange()
        
//        let proxyLabel = UILabel.appearance()
//        proxyLabel.textColor = textColor
        
        UITableViewCell.appearance().backgroundColor = backgroundColor
        let proxyView = UIView.appearance(whenContainedInInstancesOf: [UITableView.self, UITableViewCell.self])
        proxyView.backgroundColor = backgroundColor
    }
}
