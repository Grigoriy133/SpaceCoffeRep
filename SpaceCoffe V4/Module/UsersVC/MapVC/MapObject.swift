





import Foundation
import MapKit
import CoreLocation
import MapKit
//класс должен быть подписан на протокол, чтобы  быть объектом карты
class mapObject: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    let geocoder = CLGeocoder()
    var objectsArray = [mapObject]()
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitile: String){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitile
    }
}


