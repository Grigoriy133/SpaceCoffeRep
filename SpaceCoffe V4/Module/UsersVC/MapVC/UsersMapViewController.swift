//
//  UsersMapViewController.swift
//  SpaceCoffe V4
//
//  Created by Grigoriy Korotaev on 06.06.2023.
//

import UIKit
import SnapKit
import CoreLocation
import MapKit


class UsersMapViewController: UIViewController {

    let mView = MapView()
    var objectsArray = [mapObject]()
    let locationManager = CLLocationManager()
    var buttonAddNewObject = UIButton()
    var buttonCleanRoute = UIButton()
    var buttonFindMe = UIButton()
    var buttonNewObjectAdress = UIButton()
    
    var numberOfObjectRouts = 0
    var lastObjectCoordinate = CLLocationCoordinate2D()
  //  var address = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAdresses()
        createMapObject()
        setupLocationManager()
        checkPermission()
    }
    override func viewDidAppear(_ animated: Bool) {
        myLocation()
    }
    override func loadView() {
        view = mView
        configurateButtons()
    }
}
// MapFunctions
extension UsersMapViewController {
    func addAdresses(){
        addNewAdressObject(title: "Санкт-Петербург", subtitle: " Кушелевская дорога 1 к1 стр1", adress: "Санкт-Петербург,  Кушелевская дорога 1")
        addNewAdressObject(title: "Ханмымей", subtitle: " ", adress: "Ханымей")
        addNewAdressObject(title: "New-York", subtitle: " ", adress: "New-York")
        addNewAdressObject(title: "Москва", subtitle: " ", adress: "Москва")
    }
    func addNewAdressObject(title: String, subtitle: String, adress: String){
        let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(adress) { (placemarks, error) in
                    if let error = error {
                        print("Geocoding error: \(error.localizedDescription)")
                        return
                    }
                    guard let placemark = placemarks?.first else {
                        print("No placemarks found")
                        return
                    }
                    let latitude = placemark.location?.coordinate.latitude
                    let longitude = placemark.location?.coordinate.longitude
                let newObject = mapObject(coordinate: CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0), title: title, subtitile: subtitle)
                self.objectsArray.append(newObject)
                 self.createMapObject()
        }
    }
    
    func createMapObject(){
        //очистка карты
        mView.mainMap.removeAnnotations(mView.mainMap.annotations)
        for object in objectsArray{
            mView.mainMap.addAnnotation(object)
        }
    }

    func checkPermission(){
        switch locationManager.authorizationStatus{
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mView.mainMap.showsUserLocation = true
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            callAlert(title: "Please turn on permission", message: nil, url: URL(string: UIApplication.openSettingsURLString))
            break
        case .restricted:
            //открытие ссылки в меню настроек
            callAlert(title: "Please turn on permission", message: nil, url: URL(string: UIApplication.openSettingsURLString))
        @unknown default:
            break
        }
    }
    
    func callAlert(title: String, message: String?, url: URL?) {
        let newAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let urlAction = UIAlertAction(title: "Go to settings", style: .default) { alert in
            if let url = url {
                UIApplication.shared.open(url,  options: [:], completionHandler: nil) }
        }
        newAlert.addAction(cancelAction)
        newAlert.addAction(urlAction)
        present(newAlert, animated: true)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        //точность определения локации
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mView.mainMap.delegate = self
    }
    
    func myLocation() {
        let location = locationManager.location?.coordinate
        let region = MKCoordinateRegion(center: location ?? CLLocationCoordinate2D(), latitudinalMeters: 10000, longitudinalMeters: 10000)
        mView.mainMap.setRegion(region, animated: true)
    }
    func configurateButtons(){
        mView.findMeButton.addTarget(self, action: #selector(find), for: .touchUpInside)
    }
    @objc func find(){
        myLocation()
    }
    
}

extension UsersMapViewController: CLLocationManagerDelegate{

    //проверка разрешения при изменении авторизации
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkPermission()
    }
}

extension UsersMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? mapObject else { return nil}
        var viewMarker: MKMarkerAnnotationView
        let idView = "Marker"
        if let view = mapView.dequeueReusableAnnotationView(withIdentifier: idView) as? MKMarkerAnnotationView{
            view.annotation = annotation
            viewMarker = view
        } else {
            viewMarker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: idView)
            viewMarker.canShowCallout = true
            viewMarker.calloutOffset = CGPoint(x: 0, y: 6)
            
            let button = UIButton()
            let button2 = UIButton()
            button.tag = 1
            button2.tag = 2
            
            button2.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
            button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            button2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            
            viewMarker.leftCalloutAccessoryView = button2
            viewMarker.leftCalloutAccessoryView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            
            
            viewMarker.rightCalloutAccessoryView = button
            viewMarker.rightCalloutAccessoryView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
          
        }
        return viewMarker
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let object = view.annotation as! mapObject
        let latitude = object.coordinate.latitude
        let longitude = object.coordinate.longitude

        switch control.tag {
        case 1:
            mView.labelSelectedStore.text = object.title
        case 2:
            let zoom = 15
            let mapType = "map"
            let urlString = "yandexmaps://maps.yandex.ru/?pt=\(longitude),\(latitude)&z=\(zoom)&l=\(mapType)"
            let url = URL(string: urlString)

            let activityViewController = UIActivityViewController(activityItems: [url ?? ""], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        default: break
        }
    }
 
}
