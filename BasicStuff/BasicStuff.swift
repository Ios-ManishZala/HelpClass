
import Foundation
import UIKit
import MapKit
import AVKit
import ProgressHUD
import DropDown



let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let synthesizer = AVSpeechSynthesizer()


//MARK: - Languagecode get From Any controller.
var myLanguageDictionary: [String:String] = [
                                          "en":"English",
                                          "es":"Spanish",
                                          "de":"German",
                                          "fr":"French",
                                          "hi":"Hindi",
                                          "fi":"Filipino",
                                          "zh-Hant":"Chinese",
                                          "it":"Italian",
                                          "tr":"Turkish",
                                          "id":"Indonesian",
                                          "ru":"Russian",
                                          "ar":"Arabic",
                                          "ja":"Japanese"]

var myLanguageSpeechDictionary: [String:String] = [
                                          "ar":"ar-SA",
                                          "cs":"cs-CZ",
                                          "da":"da-DK",
                                          "de":"de-DE",
                                          "el":"el-GR",
                                          "en":"en-US",
                                          "es":"es-ES",
                                          "fi":"fi-FI",
                                          "fr":"fr-FR",
                                          "he":"he-IL",
                                          "hi":"hi-IN",
                                          "hu":"hu-HU",
                                          "id":"id-ID",
                                          "it":"it-IT",
                                          "ja":"ja-JP",
                                          "ko":"ko-KR",
                                          "nl":"nl-NL",
                                          "no":"no-NO",
                                          "pl":"pl-PL",
                                          "pt":"pt-BR",
                                          "ro":"ro-RO",
                                          "ru":"ru-RU",
                                          "sk":"sk-SK",
                                          "sv":"sv-SE",
                                          "th":"th-TH",
                                          "tr":"tr-TR",
                                          "zh-Hant":"zh-CN"]

//MARK: - get SetAppLanguageCode.
func getAppLanguagesCode() -> String?{
    return  UserDefaults.standard.string(forKey: "Applanguage")
}

//MARK: - get SetAppLanguageCode.
func getDisplayMode() -> Bool{
    return  UserDefaults.standard.bool(forKey: "Display_Mode")
}

extension UIStoryboard {
    enum Name: String {
        case main = "TabBar"
    }
}

//MARK: - CheckPhone is IphoneX or Not.
func isIphoneX() -> Bool {
    if( UIDevice.current.userInterfaceIdiom == .phone) {
        if(UIScreen.main.bounds.size.height >= 812) {
            return true
        }
    }
    return false
}

//MARK: - Alert and Storyboard Object.
extension UIViewController {
    
    static func object(_ storyboardName: UIStoryboard.Name = UIStoryboard.Name.main) -> Self {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as! Self
    }
    
    static func object(_ string:String,_ storyboardName: UIStoryboard.Name = UIStoryboard.Name.main) -> Self {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: string) as! Self
    }
    
    static func nib() -> Self {
        return UIViewController(nibName: String(describing: Self.self), bundle: Bundle.main) as! Self
    }
    
    func showAlert(title : String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertPermission(title : String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let settingAction = UIAlertAction(title: "Setting", style: .default, handler: { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else {
               return
            }
            DispatchQueue.main.async {
                if UIApplication.shared.canOpenURL(url) {
                   UIApplication.shared.open(url, options: [:])
                }
            }
        })
        alertController.addAction(okAction)
        alertController.addAction(settingAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK: -  For the log -

struct JSN {
    static var isNetworkConnected:Bool = false
    static func log(_ logMessage: String,_ args:Any... , functionName: String = #function ,file:String = #file,line:Int = #line) {
        
        let newArgs = args.map({arg -> CVarArg in String(describing: arg)})
        let messageFormat = String(format: logMessage, arguments: newArgs)
        
        print("LOG :- \(((file as NSString).lastPathComponent as NSString).deletingPathExtension)--> \(functionName) ,Line:\(line) :", messageFormat)
    }
    static func error(_ logMessage: String,_ args:Any... , functionName: String = #function ,file:String = #file,line:Int = #line) {
        
        let newArgs = args.map({arg -> CVarArg in String(describing: arg)})
        let messageFormat = String(format: logMessage, arguments: newArgs)
        
        print("ERROR :- \(((file as NSString).lastPathComponent as NSString).deletingPathExtension)--> \(functionName) ,Line:\(line) :", messageFormat)
    }
}


//MARK: - Controller UseFul.
extension UIViewController {
    func navigateToHome() {
        let frontViewController = HomeVC()
        let frontNavigationController = UINavigationController(rootViewController: frontViewController)
        frontNavigationController.setNavigationBarHidden(true, animated: false)
        frontNavigationController.interactivePopGestureRecognizer?.isEnabled = true
        self.view.window?.rootViewController = frontNavigationController
    }

    func navigateToLogin() {
//        let frontViewController = LoginVC()
//        let frontNavigationController = UINavigationController(rootViewController: frontViewController)
//        frontNavigationController.setNavigationBarHidden(true, animated: false)
//        self.view.window?.rootViewController = frontNavigationController
    }
    
    var notchHeight:CGFloat {
        let window = UIApplication.shared.windows[0]
        return window.safeAreaInsets.top
//        let bottomPadding = window.safeAreaInsets.bottom
    }
}


//MARK: - PreviouesViewController Find And Pop.
extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        }else {
            return nil
        }
    }  
}

extension UIView {
    
    //MARK: - Circle Dashed Line.
    func addDashedCircle() {
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        circleLayer.lineWidth = 2.0
        circleLayer.strokeColor =  UIColor.mainColor.cgColor//border of circle
        circleLayer.fillColor = UIColor.clear.cgColor //inside the circle
        circleLayer.lineJoin = .round
        circleLayer.lineDashPattern = [6,3]
        layer.addSublayer(circleLayer)
    }
    
    //MARK: - Give DashedLine from View.
    func addDashedBorder() {
        let color = UIColor.mainColor.cgColor
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: (frameSize.width - 40)/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        self.layer.addSublayer(shapeLayer)
    }
}

//MARK: - Shadow Functionality.
extension UIView {
    func shadow(shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat) {
        layer.shadowOffset = shadowOffset
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
    func buttonShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.09).cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 4)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 12.0
        self.layer.masksToBounds = false
    }
    
    func tabShadow(color:CGColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor) {
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 3
        layer.masksToBounds = false
        clipsToBounds = false
//        let shadowPath0 = UIBezierPath(roundedRect: self.bounds , cornerRadius: 0)
//        let layer0 = CALayer()
//        layer0.shadowPath = shadowPath0.cgPath
//        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
//        layer0.shadowOpacity = 1
//        layer0.shadowRadius = 6
//        layer0.shadowOffset = CGSize(width: 0, height: 2)
//        layer0.bounds = self.bounds
//        layer0.position = self.center
//        layer0.backgroundColor = color
//        self.layer.addSublayer(layer0)
    }
    
    func addShadow(_ color:CGColor = UIColor.gray.cgColor) {
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 9
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
    func addLightShadow(_ color:CGColor = UIColor.lightGray.cgColor) {
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowColor = color
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 8
        layer.masksToBounds = false
        clipsToBounds = false
    }
}

//MARK: - Add Radiues OF View.
extension UIView{
    
    func makeTopCornerRound(_ cornerRadius:Double = 10) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    func makeBottomCornerRound(_ cornerRadius:Double = 20) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    func makeThreeReciverCornerRound(_ cornerRadius:Double = 10) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    func makeThreeSenderCornerRound(_ cornerRadius:Double = 10) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    func makeLeftTopandBottomRound(_ cornerRadius:Double = 10) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    func makeRightTopandBottomRound(_ cornerRadius:Double = 10) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    func makeTopLeft(_ cornerRadius:Double = 10) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMinXMinYCorner]
    }
    func makeLeftBottom (_ cornerRadius:Double = 10) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMinXMaxYCorner]
    }
    func makeTopRight(_ cornerRadius:Double = 10) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMaxXMinYCorner]
    }
    func makeRightBottom (_ cornerRadius:Double = 10) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMaxXMaxYCorner]
    }
    
    func makeLeftBottomAndTopRight(_ cornerRadius:Double = 10) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMinXMaxYCorner , .layerMaxXMinYCorner]
    }
    func makeLeftTopAndRightBottom(_ cornerRadius:Double = 10) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMinXMinYCorner , .layerMaxXMaxYCorner]
    }
    func makeTopLeftandBottomandLeftBottom(_ cornerRadius:Double = 10) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner ,.layerMinXMaxYCorner]
    }
    
    func makeTopLeftandBottomandRightBottom(_ cornerRadius:Double = 10) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMaxXMinYCorner , .layerMinXMinYCorner ,.layerMaxXMaxYCorner]
    }
    
    func makeRounded() {
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}


//MARK: - Declare Global Color For App.
extension UIColor {
    static let Fontcolor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    static let mainColor = UIColor(named: "maincolor")!
    static let button_color = UIColor(named: "button_color")!
    static let fontGrayColor =  UIColor(red: 0.704, green: 0.704, blue: 0.704, alpha: 1)
    static let bgColor =  UIColor(named: "bgcolor")!
    static let textBlack = UIColor(named: "fontGrayColor")!
    static let borer_color = UIColor(named: "borer_color")!
    static let view_bordercolor = UIColor(named: "view_bordercolor")!
    
    static let tbvcell_color = UIColor(named: "tbvcell_color")!
    static let blueColor = #colorLiteral(red: 0.5803921819, green: 0.5725490451, blue: 1, alpha: 1)
    
    static var placeholderGray: UIColor {
        return UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    }
}

//MARK: - Datepicker Generic Function.
extension UITextField {
    @available(iOS 13.4, *)
    func datePicker<T>(target: T,
                       doneAction: Selector,
                       cancelAction: Selector,
                       datePickerMode: UIDatePicker.Mode = .date) {
        // Code goes here
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenWidth,
                                                    height: 216))
        datePicker.datePickerMode = datePickerMode
        datePicker.preferredDatePickerStyle = .wheels
        self.inputView = datePicker
    }
}

//MARK: - Get MostViewController.
func getTopMostViewController() -> UIViewController? {
    var topMostViewController = UIApplication.shared.keyWindow?.rootViewController
    while let presentedViewController = topMostViewController?.presentedViewController {
        topMostViewController = presentedViewController
    }
    return topMostViewController
}


//MARK:  - getDate.

func formatDate(format:String? = "MM-dd-yyyy h:mm:ss a") -> String {
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = format
    return timeFormatter.string(from: Date())
}

extension UITextField {

  //MARK: - Set Image on the Right of TextField.
  func setupRightImage(imageName:String){
    let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
    imageView.image = UIImage(named: imageName)
    let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    imageContainerView.addSubview(imageView)
    rightView = imageContainerView
    rightViewMode = .always
    self.tintColor = .lightGray
}

   //MARK: - Set Image on Left of TextField.
    func setupLeftImage(imageName:String){
       let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
       imageView.image = UIImage(named: imageName)
       let imageContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
       imageContainerView.addSubview(imageView)
       leftView = imageContainerView
        leftViewMode = .always
       self.tintColor = .lightGray
     }
  }

extension UIView{
    
    //MARK: - Get Parent View Controller from any view.
    func parentViewController() -> UIViewController {
        var responder: UIResponder? = self
        while !(responder is UIViewController) {
            responder = responder?.next
            if nil == responder {
                break
            }
        }
        return (responder as? UIViewController)!
    }
}


//MARK: - Manage collectionview Cell Space Like Show as Tag.
class TagsLayout: UICollectionViewFlowLayout {
    
    required override init() {super.init(); common()}
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); common()}
    
    private func common() {
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
    }
    override func layoutAttributesForElements(
        in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            
            guard let att = super.layoutAttributesForElements(in:rect) else {return []}
            var x: CGFloat = sectionInset.left
            var y: CGFloat = -1.0
            
            for a in att {
                if a.representedElementCategory != .cell { continue }
                
                if a.frame.origin.y >= y { x = sectionInset.left }
                a.frame.origin.x = x
                x += a.frame.width + minimumInteritemSpacing
                y = a.frame.maxY
            }
            print(att)
            return att
        }
}

//MARK: - DrawDottedImage.
extension UIImageView {
    static func drawDottedImage(width: CGFloat, height: CGFloat, color: UIColor) -> UIImage {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 1.0, y: 1.0))
        path.addLine(to: CGPoint(x: width, y: 1))
        path.lineWidth = 1.5
        let dashes: [CGFloat] = [path.lineWidth, path.lineWidth * 5]
        path.setLineDash(dashes, count: 2, phase: 0)
        path.lineCapStyle = .butt
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 2)
        color.setStroke()
        path.stroke()
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

//MARK: - Custom DashedView.
class CustomDashedView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0
    
    var dashBorder: CAShapeLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if cornerRadius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}

//MARK: - Set custom MarkerPin on Map.
class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    let image: UIImage?
    
    init(pinTitle:String, pinSubTitle:String,image:UIImage, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
        self.image = image
        super.init()
    }
}


extension UIView{
    
    //MARK: - SetGradientColor From Any View.
    func setGradientBackground(startColor:UIColor) {
        let colorTop =  startColor.cgColor
        let colorBottom =  UIColor.white.cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.8]
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}

//MARK: - Set Button Shadow and Name as Globally.
//extension UIButton{
//    
//    func setButtonTitleAndFunctionality(_ Name:String,textFont:UIFont? = UIFont(name: "Lexend-Medium", size: isIpad() ? 30 : 15)) {
//        self.layer.masksToBounds = false
//        self.layer.cornerRadius = 15
//        self.setTitle(Name, for: .normal)
//        self.titleLabel?.font = textFont
//        self.backgroundColor = .button_color
//        self.setTitleColor(UIColor.white, for: .normal)
//        self.clipsToBounds = false
//    }
//}

//MARK: - Navigation Configration.
extension UIViewController{
    func pushVC(_ Name:UIViewController){
        let vc = Name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Compare Date.
    
//    func compareDates(_ chatGPTData:[ChatGPTConverstionModel],_ completion:@escaping([ChatGPTConverstionModel],[ChatGPTConverstionModel])->()){
//        let calendar = Calendar.current
//        let today = calendar.startOfDay(for: Date())
//        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
//        var yesterDaySearchresult:[ChatGPTConverstionModel] = []
//        var toDaySearchresult:[ChatGPTConverstionModel] = []
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM-dd-yyyy h:mm:ss a" // Set your desired date format
//        
//        // Example dates to compare.
//        let result = chatGPTData.map { chatGPTDatum -> String in
//            let date1 = dateFormatter.date(from: chatGPTDatum.conversationID)!
//            let isToday = calendar.isDate(date1, inSameDayAs: today)
//            let isYesterday = calendar.isDate(date1, inSameDayAs: yesterday)
//            
//            if isToday {
//                toDaySearchresult.append(chatGPTDatum)
//                return "Today"
//            }
//            else if isYesterday {
//                yesterDaySearchresult.append(chatGPTDatum)
//                return "yesterday"
//            }
//            else {
//                return dateFormatter.string(from: date1)
//            }
//        }
//        completion(toDaySearchresult,yesterDaySearchresult)
//
////        for chatGPTDatum in chatGPTData {
////            let date1 = dateFormatter.date(from: chatGPTDatum.conversationID)!
////            let isToday = calendar.isDate(date1, inSameDayAs: today)
////            let isYesterday = calendar.isDate(date1, inSameDayAs: yesterday)
////
////            if isToday {
////                print("Today")
////            }
////            else if isYesterday {
////                print("Yesterday")
////            }
////            else {
////                print(dateFormatter.string(from: date1))
////            }
////        }
//    }
    
    //MARK: - Dropdown confirigation

    func dropDownConfirgration(anchorview:AnchorView?,width:CGFloat?,datasource:[String],dropDown:DropDown){
        dropDown.anchorView = anchorview
        dropDown.width = width
        dropDown.backgroundColor = .white
        dropDown.cornerRadius = 10
        dropDown.bottomOffset = CGPoint(x: 20, y: 35)
        dropDown.dataSource = datasource
        dropDown.show()
    }
}

extension UIViewController {
    
    //MARK: - Progressbar Setup.
    func setupProgressBar(){
        ProgressHUD.animationType = .multipleCircleScaleRipple
        ProgressHUD.colorAnimation = .button_color
        ProgressHUD.colorProgress = .button_color
        ProgressHUD.colorStatus = .button_color
        ProgressHUD.colorBackground = .clear
        ProgressHUD.fontStatus = UIFont(name: "Spartan-Medium", size: 18) ?? UIFont()
    }
    
    //MARK: - ShowToast Message.
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 200, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

//MARK: - CheckAuthentication USeful.
extension String{
    
    func IsValidphone() -> Bool {
        let phoneRegEx = "[0-9]{10}"
        return applyPredictOnRange(regRgx: phoneRegEx)
    }
    func IsvalidPassword()->Bool{
        let passwordRgx = "[A-Z]{1,2}+[a-z]{3,9}+[@&$]{1}+[0-9]{1,4}"
        return applyPredictOnRange(regRgx: passwordRgx)
    }
    func applyPredictOnRange(regRgx : String)->Bool {
        let trimmerstring = self.trimmingCharacters(in: .whitespaces)
        let phonetest = NSPredicate(format: "SELF MATCHES %@", regRgx)
        let invalidstring = phonetest.evaluate(with:trimmerstring)
        return invalidstring
    }
    func IsValidOtp() -> Bool{
        let phoneRegEx = "[0-9]{10}"
        return applyPredictOnRange(regRgx: phoneRegEx)
    }
}

//MARK: - CreatboderLine Of View.
extension UIView {
   func createDottedLine(width: CGFloat, color: CGColor) {
      let caShapeLayer = CAShapeLayer()
      caShapeLayer.strokeColor = color
      caShapeLayer.lineWidth = width
      caShapeLayer.lineDashPattern = [2,3]
      let cgPath = CGMutablePath()
      let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width - 25, y: 0)]
      cgPath.addLines(between: cgPoint)
      caShapeLayer.path = cgPath
      layer.addSublayer(caShapeLayer)
   }
}

//MARK: - Share AppLink.
extension UIViewController{
    func share(message: String, link: String) {
        if let link = NSURL(string: link) {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            getTopMostViewController()?.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func shareText(_ text: String, from viewController: UIViewController) {
        JSN.log("Message text ==>%@", text)
        
        let bigMessage = """
                        \(text)
                        """
        let activityViewController = UIActivityViewController(activityItems: [bigMessage], applicationActivities: nil)
        viewController.present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: - Share text in Whatsapp.
    func shareMessageOnWhatsApp(_ message: String, viewController: UIViewController) {
        let whatsappURL = URL(string: "whatsapp://send?text=\(message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")")!
        
        print(whatsappURL)
        if UIApplication.shared.canOpenURL(whatsappURL) {
            UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
        } else {
            let alertController = UIAlertController(title: "WhatsApp Not Installed", message: "Please install WhatsApp to share this message.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
}

//MARK: - GetparentView From View.
extension UIView {
    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return parentView(of: UITableView.self)
    }
}

//MARK: - Change StatusBar Color.
extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

//MARK: - Change Font Weigth with custom FamilyFont.
public extension UIFont {
    /// Returns a new font with the weight specified
    ///
    /// - Parameter weight: The new font weight
    func fontWeight(_ weight: UIFont.Weight) -> UIFont {
        let fontDescriptor = UIFontDescriptor(fontAttributes: [
            UIFontDescriptor.AttributeName.size: pointSize,
            UIFontDescriptor.AttributeName.family: familyName
        ])

        // Add the font weight to the descriptor
        let weightedFontDescriptor = fontDescriptor.addingAttributes([
            UIFontDescriptor.AttributeName.traits: [
                UIFontDescriptor.TraitKey.weight: weight
            ]
        ])
        return UIFont(descriptor: weightedFontDescriptor, size: 0)
    }
}


//MARK: - Set Button Shadow and Name as Globally.
extension UIButton {

    func setButtonTitleAndFunctionality(_ Name:String,cornerRadiues:Double = 15, textFont:UIFont? = UIFont(name: "Lexend-Medium", size: isIpad() ? 30 : 15)) {
        self.setTitle(Name, for: .normal)
        self.titleLabel?.font = textFont
        self.setTitleColor(UIColor.white, for: .normal)
        self.layer.cornerRadius = cornerRadiues
        self.clipsToBounds = true

        //MARK: - Add GradientButton.
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.908, green: 0.467, blue: 0.061, alpha: 1).cgColor,
            UIColor(red: 0.739, green: 0.061, blue: 0.908, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.position = self.center
        gradientLayer.frame = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

//MARK: - insert GradientLayer.

extension UIView {

    func inssertGradientLayer(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0, green: 0.58, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.019, green: 0.184, blue: 0.767, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.position = self.center
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = 10
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}


//MARK: - Dropdwon ConfyGration.

//extension UIViewController {
//    
//    func dropDownconfygration2(dropDown:DropDown,senderView:UIView){
//        dropDown.anchorView = senderView
//        dropDown.width =  110
//        dropDown.textColor = (traitCollection.userInterfaceStyle == .dark) ? .black : .white
//        dropDown.backgroundColor = .bgColor
//        dropDown.cornerRadius = 10
//        dropDown.textFont = UIFont(name: "Poppins-Medium", size: 10)!
//        dropDown.bottomOffset = CGPoint(x: 0, y: dropDown.anchorView!.plainView.bounds.height)
//        dropDown.selectionBackgroundColor = .white
//        dropDown.dataSource = ["Afrikaans",
//                               "Italian",
//                               "Hindi",
//                               "German",
//                               "Bulgarian",
//                               "Catalan",
//                               "Chinese",
//                               "Croatian",
//                               "Czech",
//                               "Danish",
//                               "English"
//                               ]
//        dropDown.show()
//    }
//}

//MARK: - translate Language

//extension UIViewController {
//
//    func translateText(_ text: String?, option: TranslatorOptions, completion: @escaping (String) -> ()) {
//        ProgressHUD.colorBackground = .clear
//        ProgressHUD.show("Loading",interaction: false)
//
//        guard let text = text else {
//            return
//        }
//
//        let translator = Translator.translator(options: option)
//        let conditions = ModelDownloadConditions(allowsCellularAccess: true , allowsBackgroundDownloading: true)
//
//        translator.downloadModelIfNeeded(with: conditions) { error in
//            guard error == nil else {
//                // Handle download error
//                return
//            }
//            translator.translate(text) { translatedText, error in
//                if let error = error {
//                    print("Translation error: \(error.localizedDescription)")
//                }
//                else if let translatedText = translatedText {
//                    DispatchQueue.main.async {
//                        ProgressHUD.dismiss()
//                        completion(translatedText)
//                    }
//                }
//            }
//        }
//    }
//}

extension UITableView {
    func updateTableContentInset() {
        let numRows = self.numberOfRows(inSection: 0)
        var contentInsetTop = self.bounds.size.height
        for i in 0..<numRows {
            let rowRect = self.rectForRow(at: IndexPath(item: i, section: 0))
            contentInsetTop -= rowRect.size.height
            if contentInsetTop <= 0 {
                contentInsetTop = 0
                break
            }
        }
        self.contentInset = UIEdgeInsets(top: contentInsetTop,left: 0,bottom: 70,right: 0)
    }
}


//MARK: - day change.
func hasDayChanged() -> Bool {
    let currentDate = Date()
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day, .month, .year], from: currentDate)
    let startOfDay = calendar.date(from: components)!

    var componentsToAdd = DateComponents()
    componentsToAdd.day = 1
    let startOfNextDay = calendar.date(byAdding: componentsToAdd, to: startOfDay)!

    return currentDate >= startOfNextDay
}


//MARK: - Convert html to string.

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}


//MARK: - Emoji Textfield Open.

class EmojiTextField: UITextField {

    // required for iOS 13
    override var textInputContextIdentifier: String? { "" } // return non-nil to show the Emoji keyboard ¯\_(ツ)_/¯

    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                return mode
            }
        }
        return nil
    }
}

//MARK: - getChristmasDate.

func getChristmasDate() -> NSDate {
    let calendar = Calendar.current
    let christmasDateComponents = DateComponents(year: calendar.component(.year, from: Date()), month: 12, day: 25)
    return calendar.date(from: christmasDateComponents)! as NSDate
}

//MARK: - Get App release Version

func getAppInfo()-> Float {
    let appVersionString: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    let appVersionInt = Float(appVersionString) ?? 0
    return appVersionInt
}

//MARK: - Remove CurrencySymbol -

extension String {
    public func removeFormatAmount() -> Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.currencySymbol = Locale.current.currencySymbol
        formatter.decimalSeparator = Locale.current.groupingSeparator
        return formatter.number(from: self)?.doubleValue ?? 0.00
    }
}


func getCurrencySymbol(from currencyCode: String) -> String? {

    let locale = NSLocale(localeIdentifier: currencyCode)
    if locale.displayName(forKey: .currencySymbol, value: currencyCode) == currencyCode {
        let newlocale = NSLocale(localeIdentifier: currencyCode.dropLast() + "_en")
        return newlocale.displayName(forKey: .currencySymbol, value: currencyCode)
    }
    return locale.displayName(forKey: .currencySymbol, value: currencyCode)
}


//MARK: - compare Date -

extension Date {
    
    func isEqualTo(_ date: Date) -> Bool {
        return self == date
    }
    
    func isGreaterThan(_ date: Date) -> Bool {
        return self > date
    }
    
    func isSmallerThan(_ date: Date) -> Bool {
        return self < date
    }
}

func isIpad() -> Bool {
    if( UIDevice.current.userInterfaceIdiom == .pad) {
        return true
    }
    return false
}



extension UITapGestureRecognizer {
   
   func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
       guard let attributedText = label.attributedText else { return false }

       let mutableStr = NSMutableAttributedString.init(attributedString: attributedText)
       mutableStr.addAttributes([NSAttributedString.Key.font : label.font!], range: NSRange.init(location: 0, length: attributedText.length))
       
       // If the label have text alignment. Delete this code if label have a default (left) aligment. Possible to add the attribute in previous adding.
       let paragraphStyle = NSMutableParagraphStyle()
       paragraphStyle.alignment = .center
       mutableStr.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: attributedText.length))

       // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
       let layoutManager = NSLayoutManager()
       let textContainer = NSTextContainer(size: CGSize.zero)
       let textStorage = NSTextStorage(attributedString: mutableStr)
       
       // Configure layoutManager and textStorage
       layoutManager.addTextContainer(textContainer)
       textStorage.addLayoutManager(layoutManager)
       
       // Configure textContainer
       textContainer.lineFragmentPadding = 0.0
       textContainer.lineBreakMode = label.lineBreakMode
       textContainer.maximumNumberOfLines = label.numberOfLines
       let labelSize = label.bounds.size
       textContainer.size = labelSize
       
       // Find the tapped character location and compare it to the specified range
       let locationOfTouchInLabel = self.location(in: label)
       let textBoundingBox = layoutManager.usedRect(for: textContainer)
       let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                         y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
       let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                    y: locationOfTouchInLabel.y - textContainerOffset.y);
       let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
       return NSLocationInRange(indexOfCharacter, targetRange)
   }
   
}

 // MARK: - CheckUrl -

extension String {
    var isValidUrl: Bool {
        let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
    }
}


//MARK: - Take ScreenSort -

func captureScreenshot(of viewToCapture: UIView) -> UIImage? {
    // Create a graphics context with the same size as the view
    UIGraphicsBeginImageContextWithOptions(viewToCapture.bounds.size, false, 0.0)
    
    // Render the view's layer into the graphics context
    viewToCapture.layer.render(in: UIGraphicsGetCurrentContext()!)
    
    // Get the screenshot as an image
    let screenshot = UIGraphicsGetImageFromCurrentImageContext()
    
    // End the graphics context
    UIGraphicsEndImageContext()
    return screenshot
}

//MARK: - AppName

extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}



extension String {
    
    public func isImage() -> Bool {
        // Add here your image formats.
        let imageFormats = ["jpg", "jpeg", "png", "gif", "webp"]
        
        if let ext = self.getExtension() {
            return imageFormats.contains(ext)
        }
        
        return false
    }
    
    public func getExtension() -> String? {
        let ext = (self as NSString).pathExtension
        
        if ext.isEmpty {
            return nil
        }
        
        return ext
    }
    
    public func isURL() -> Bool {
        return URL(string: self) != nil
    }
}


extension URL {
    var attributes: [FileAttributeKey : Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }
    
    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }
    
    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }
    
    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
}


extension UIBarButtonItem {
    func set(hide: Bool) {
        isEnabled = !hide
        tintColor = hide ? .clear : .black
    }
}



class DeleteAlert {

    static let shared = DeleteAlert()

    private init() {} // Ensure it's a singleton

    func showDeleteAlert(onViewController viewController: UIViewController, deleteHandler: @escaping () -> Void) {
        let alertController = UIAlertController(
            title: "Delete",
            message: "Are you sure you want to delete this item?",
            preferredStyle: .alert
        )

        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        )

        let deleteAction = UIAlertAction(
            title: "Delete",
            style: .destructive,
            handler: { (action) in
                deleteHandler() // Call the delete handler provided
            }
        )

        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}

extension Int {
    var boolValue: Bool { return self != 0 }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}


func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
