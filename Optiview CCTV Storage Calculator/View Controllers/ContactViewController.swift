//
//  ContactViewController.swift
//  CCTV Storage Calculator
//

import UIKit
import MapKit
import MessageUI

class ContactViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    // IB Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var navigateAddressButton: UIButton!
    @IBOutlet weak var salesTitleLabel: UILabel!
    @IBOutlet weak var salesPhoneButton: UIButton!
    @IBOutlet weak var techSupportPhoneButton: UIButton!
    @IBOutlet weak var techSupportTitleLabel: UILabel!
    @IBOutlet weak var salesEmailButton: UIButton!
    @IBOutlet weak var techSupportEmailButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    
    // Constants
    let optiviewSalesPhoneText = "8 (800) 511-87-64"
    let optiviewTechSupportPhoneText = "8 (342) 219-50-90"
    let optiviewSalesEmailText = "b2b.domru@domru.ru"
    let optiviewTechSupportEmailText = "support@b2b.domru.ru"
    let optiviewAddressText = "Россия, г. Пермь, ул. Шоссе Космонавтов, 111и к2"
    
    // Create function to center map
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 750
        let optiviewLocation = CLLocationCoordinate2D(latitude: 57.990949,
                                                      longitude: 56.204048)
        let mapPin = MapPin(title: "Телеком центр",
                            locationName: "Шоссе Космонавтов, 111и к2",
                            discipline: "Office",
                            coordinate: optiviewLocation)
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        mapView.addAnnotation(mapPin)
        mapView.setRegion(coordinateRegion,
                          animated: true)
    }
    
    // View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupText()
        setupMap()
        centerOptiviewLocation()
    }
    
    // Setup text
    func setupText() {
        
        // Setup Sales Text
        setupSalesText()
        
        // Setup Tech Support Text
        setupTechSupportText()
    
        // Address Button
        setupAddressButtonText()
        
        // Location Label
        setupLocationLabelText()
    }
    
    func setupSalesText() {
        
        salesTitleLabel.textAlignment = .center
        salesPhoneButton.setTitle(optiviewSalesPhoneText, for: .normal)
        salesEmailButton.setTitle(optiviewSalesEmailText, for: .normal)
        salesEmailButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func setupTechSupportText() {
        
        techSupportTitleLabel.textAlignment = .center
        techSupportPhoneButton.setTitle(optiviewTechSupportPhoneText, for: .normal)
        techSupportEmailButton.setTitle(optiviewTechSupportEmailText, for: .normal)
        techSupportEmailButton.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func setupAddressButtonText() {
        
        // Navigation Button Title
        navigateAddressButton.setTitle("Navigate", for: .normal)
    }
    
    func setupLocationLabelText() {
        
        // Location Label
        locationLabel.textAlignment = .center
        locationLabel.numberOfLines = 0
        locationLabel.text = optiviewAddressText
    }
    
    // Set up map
    func setupMap() {
        
        // Map can zoom
        mapView.isZoomEnabled = true
        
        // Map can scroll
        mapView.isScrollEnabled = true
        
        // Map can rotate
        mapView.isRotateEnabled = true
        
        // Map's pitch is enabled
        mapView.isPitchEnabled = true
        
        // Pitch's Angle
        mapView.camera.pitch = 15.0
    }
    
    // Create function to center optiview on map
    func centerOptiviewLocation() {
        let optiviewLocation = CLLocation(latitude: 57.990949,
        longitude: 56.204048)
        centerMapOnLocation(location: optiviewLocation)
    }
    
    // Create function to call sales
    func callSalesPhoneNumber()  {
        let url: NSURL = URL(string: "TEL://88005118764")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    // Create function to call tech support
    func callTechSupportPhoneNumber()  {
        let url: NSURL = URL(string: "TEL://83422195090")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    // Create button for when address button is tapped
    func addressButtonTapped() {
        let optiviewAddressLink = "https://maps.apple.com/place?q=%D1%88%D0%BE%D1%81%D1%81%D0%B5%20%D0%9A%D0%BE%D1%81%D0%BC%D0%BE%D0%BD%D0%B0%D0%B2%D1%82%D0%BE%D0%B2%2C%20111%20%D0%BA43&ll=57.990949%2C56.204048&address=%D1%88%D0%BE%D1%81%D1%81%D0%B5%20%D0%9A%D0%BE%D1%81%D0%BC%D0%BE%D0%BD%D0%B0%D0%B2%D1%82%D0%BE%D0%B2%2C%20111%20%D0%BA43%2C%20%D0%9F%D0%B5%D1%80%D0%BC%D1%8C%2C%20%D0%9F%D0%B5%D1%80%D0%BC%D1%81%D0%BA%D0%B8%D0%B9%20%D0%BA%D1%80%D0%B0%D0%B9%2C%20%D0%A0%D0%BE%D1%81%D1%81%D0%B8%D1%8F%2C%20614066"
        let url: NSURL = URL(string: optiviewAddressLink)! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        
    }
    
    // Create function to email sales
    func emailSales() {
        let emailTitle = "Подключение 'Телеком центр'"
        let messageBody = "Я связываюсь с вами через ваше мобильное приложение"
        let toRecipents = ["b2b.domru@domru.ru"]
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        mc.setToRecipients(toRecipents)
        self.present(mc, animated: true, completion: nil)
    }
    
    // Create function to email tech support
    func emailTechSupport() {
        let emailTitle = "Техподдержка 'Телеком центр'"
        let messageBody = "Я связываюсь с вами через ваше мобильное приложение"
        let toRecipents = ["support@b2b.domru.ru"]
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        mc.setToRecipients(toRecipents)
        self.present(mc, animated: true, completion: nil)
    }
    
    // Create switch inside function to control mail results
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("Mail cancelled")
            self.dismiss(animated: true, completion: messageCancelledAlert)
        case .saved:
            print("Mail saved")
            self.dismiss(animated: true, completion: messageSavedAlert)
        case .sent:
            print("Mail sent")
            self.dismiss(animated: true, completion: messageSentAlert)
        case .failed:
            print("Mail sent failure")
            self.dismiss(animated: true, completion: messageFailedAlert)
        default:
            break
        }
    }
    
    // Create alert to show after mail has been cancelled
    func messageCancelledAlert() {
        let alertController = UIAlertController(title: "Message Cancelled",
                                                message: "Your message was cancelled.",
                                                preferredStyle: .alert)
        
        // Create OK button
        let OKAction = UIAlertAction(title: "OK",
                                     style: .default) { (action:UIAlertAction!) in
            
                                        // Code in this block will trigger when OK button tapped.
                                        print("Message cancelled")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)

    }
    
    // Create alert to show after mail has been sent
    func messageSentAlert() {
        let alertController = UIAlertController(title: "Message Sent",
                                                message: "Your message was successfully sent!",
                                                preferredStyle: .alert)
        
        // Create OK button
        let OKAction = UIAlertAction(title: "OK",
                                     style: .default) { (action:UIAlertAction!) in
            
                                        // Code in this block will trigger when OK button tapped.
                                        print("Message sent")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)

    }
    
    // Create alert to show after mail has been saved
    func messageSavedAlert() {
        let alertController = UIAlertController(title: "Message Saved",
                                                message: "Your message was successfully saved.",
                                                preferredStyle: .alert)
        
        // Create OK button
        let OKAction = UIAlertAction(title: "OK",
                                     style: .default) { (action:UIAlertAction!) in
            
                                        // Code in this block will trigger when OK button tapped.
                                        print("Message saved")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)

    }
    
    // Create alert to show after mail has failed to send
    func messageFailedAlert() {
        let alertController = UIAlertController(title: "Message Sending Failed",
                                                message: "Your message failed to send. Please check your connection and try again.",
                                                preferredStyle: .alert)
        
        // Create OK button
        let OKAction = UIAlertAction(title: "OK",
                                     style: .default) { (action:UIAlertAction!) in
            
                                        // Code in this block will trigger when OK button tapped.
                                        print("Message failed to send.")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)

    }
    
    // Call addressButtonTapped() function when button pressed
    @IBAction func navigateAddressButtonTapped(_ sender: UIButton) {
        addressButtonTapped()
    }
    
    // Sales phone number tapped
    @IBAction func salesPhoneNumberButtonTapped(_ sender: UIButton) {
        self.callSalesPhoneNumber()
    }
    
    // Tech Support phone number tapped
    @IBAction func techSupportPhoneNumberTapped(_ sender: UIButton) {
        self.callTechSupportPhoneNumber()
    }
    
    // Sales email address tapped
    @IBAction func salesEmailButtonTapped(_ sender: UIButton) {
        emailSales()
    }

    // Tech Support email address tapped
    @IBAction func techSupportEmailButtonTapped(_ sender: UIButton) {
        emailTechSupport()
    }
    
    // Create a class MapPin for annotation on map
    class MapPin: NSObject, MKAnnotation {
      let title: String?
      let locationName: String
      let discipline: String
      let coordinate: CLLocationCoordinate2D
      
      init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
      }
      
      var subtitle: String? {
        return locationName
      }
    }
}
