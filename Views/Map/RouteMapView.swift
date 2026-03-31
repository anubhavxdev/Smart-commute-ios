import SwiftUI
import MapKit

struct RouteMapView: UIViewRepresentable {
    var pickupCoordinate: CLLocationCoordinate2D
    var dropCoordinate: CLLocationCoordinate2D
    var driverLocation: CLLocationCoordinate2D?
    var nearbyDrivers: [NearbyDriver]
    var showRoute: Bool
    var bookingState: BookingState
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = false
        mapView.showsCompass = false
        mapView.mapType = .standard
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        
        if showRoute {
            // Add pickup pin
            let pickupPin = MKPointAnnotation()
            pickupPin.coordinate = pickupCoordinate
            pickupPin.title = "Pickup"
            mapView.addAnnotation(pickupPin)
            
            // Add drop pin
            let dropPin = MKPointAnnotation()
            dropPin.coordinate = dropCoordinate
            dropPin.title = "Drop"
            mapView.addAnnotation(dropPin)
            
            // Calculate and show route
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickupCoordinate))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: dropCoordinate))
            request.transportType = .automobile
            
            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                guard let route = response?.routes.first else {
                    // Fallback: draw straight line
                    let coords = [pickupCoordinate, dropCoordinate]
                    let polyline = MKPolyline(coordinates: coords, count: 2)
                    mapView.addOverlay(polyline)
                    
                    let rect = polyline.boundingMapRect
                    mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 100, left: 60, bottom: 350, right: 60), animated: true)
                    return
                }
                
                mapView.addOverlay(route.polyline)
                let rect = route.polyline.boundingMapRect
                mapView.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 100, left: 60, bottom: 350, right: 60), animated: true)
            }
        } else if bookingState == .rideConfirmed, let driverLoc = driverLocation {
            // Show driver annotation
            let driverAnnotation = DriverAnnotation()
            driverAnnotation.coordinate = driverLoc
            driverAnnotation.title = "Captain"
            mapView.addAnnotation(driverAnnotation)
            
            let userPin = MKPointAnnotation()
            userPin.coordinate = pickupCoordinate
            userPin.title = "You"
            mapView.addAnnotation(userPin)
            
            let annotations = mapView.annotations
            mapView.showAnnotations(annotations, animated: true)
        } else {
            // Show nearby drivers
            for driver in nearbyDrivers {
                let annotation = DriverAnnotation()
                annotation.coordinate = driver.coordinate
                annotation.title = driver.vehicleType.rawValue
                mapView.addAnnotation(annotation)
            }
            
            let center = pickupCoordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
            mapView.setRegion(MKCoordinateRegion(center: center, span: span), animated: false)
        }
    }
    
    class DriverAnnotation: MKPointAnnotation {}
    
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(polyline: polyline)
                renderer.strokeColor = UIColor.black
                renderer.lineWidth = 5
                renderer.lineCap = .round
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation { return nil }
            
            if annotation is DriverAnnotation {
                let identifier = "driver"
                var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                if view == nil {
                    view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    view?.canShowCallout = false
                } else {
                    view?.annotation = annotation
                }
                
                let size: CGFloat = 32
                let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .bold)
                
                let icon: String
                let bgColor: UIColor
                
                if annotation.title == "Captain" {
                    icon = "car.front.waves.up.fill"
                    bgColor = .black
                } else if annotation.title == "Bike" {
                    icon = "bicycle"
                    bgColor = .darkGray
                } else if annotation.title == "Auto" {
                    icon = "car.2.fill"
                    bgColor = UIColor(red: 0.2, green: 0.6, blue: 0.2, alpha: 1)
                } else {
                    icon = "car.fill"
                    bgColor = UIColor(red: 0.2, green: 0.4, blue: 0.8, alpha: 1)
                }
                
                let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))
                let image = renderer.image { ctx in
                    bgColor.setFill()
                    UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size, height: size)).fill()
                    
                    if let symbolImage = UIImage(systemName: icon, withConfiguration: config)?.withTintColor(.white, renderingMode: .alwaysOriginal) {
                        let symbolSize = symbolImage.size
                        let point = CGPoint(x: (size - symbolSize.width) / 2, y: (size - symbolSize.height) / 2)
                        symbolImage.draw(at: point)
                    }
                }
                view?.image = image
                view?.frame.size = CGSize(width: size, height: size)
                return view
                
            } else {
                // Pickup / Drop pins
                let identifier = "place"
                var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
                if view == nil {
                    view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                } else {
                    view?.annotation = annotation
                }
                view?.canShowCallout = true
                if annotation.title == "Pickup" {
                    view?.markerTintColor = .systemGreen
                    view?.glyphImage = UIImage(systemName: "figure.wave")
                } else {
                    view?.markerTintColor = .systemRed
                    view?.glyphImage = UIImage(systemName: "flag.checkered")
                }
                return view
            }
        }
    }
}
