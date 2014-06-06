import UIKit
import CoreLocation

class View : UITableViewController, CLLocationManagerDelegate
{
    // Variablen
    var LocationManager : CLLocationManager?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        LocationManager = CLLocationManager()
        
        if LocationManager
        {
            LocationManager!.delegate = self
            LocationManager!.desiredAccuracy = kCLLocationAccuracyBest
            
            LocationManager!.startMonitoringSignificantLocationChanges()
            LocationManager!.startUpdatingLocation()
        }
        else
        {
            UIAlertView(title: "Fehler", message: "GPS konnte nicht initialisiert werden!", delegate: self, cancelButtonTitle: "OK").show()
        }
    }
    
    deinit
    {
        LocationManager?.stopMonitoringSignificantLocationChanges()
        LocationManager?.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!)
    {
        UIAlertView(title: "Fehler", message: error.description, delegate: self, cancelButtonTitle: "OK").show()
    }
    
    func locationManager(manager: CLLocationManager!, didFinishDeferredUpdatesWithError error: NSError!)
    {
        UIAlertView(title: "Fehler", message: error.description, delegate: self, cancelButtonTitle: "OK").show()
    }
    
    func locationManager(manager: CLLocationManager!,didUpdateLocations locations: AnyObject[]!)
    {
        let location = (locations as Array<CLLocation>)[0]
        
        func cellText(idx: Int, text: String)
        {
            self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: idx, inSection: 0)).detailTextLabel.text = text
        }
        
        cellText(0, "\(location.coordinate.latitude)")
        cellText(1, "\(location.coordinate.longitude)")
        cellText(2, "\(location.altitude)")
        cellText(3, "\(location.verticalAccuracy)")
        cellText(4, "\(location.horizontalAccuracy)")
        cellText(5, "\(location.speed)")
        cellText(6, "\(location.course)")
    }
}
