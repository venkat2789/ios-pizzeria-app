//
//  MapView.swift
//  Pizzeria
//
//  Created by Venkatachalapathy Sivaprakasam on 6/5/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: LocationHelper.currentLocation.latitude, longitude: LocationHelper.currentLocation.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    
    var body: some View {
        
        let locations = [
            Location(name: "My Store 1", coordinate: CLLocationCoordinate2D(latitude: mapRegion.center.latitude.advanced(by: 0.0002), longitude: mapRegion.center.latitude.advanced(by: 0.0002))),
            Location(name: "My Store 1", coordinate: CLLocationCoordinate2D(latitude: mapRegion.center.latitude.advanced(by: 0.0002), longitude: mapRegion.center.latitude.advanced(by: 0.0002)))
        ]
        
        VStack {
            Text("lat: \(mapRegion.center.latitude), long: \(mapRegion.center.longitude). Zoom: \(mapRegion.span.latitudeDelta)")
            .font(.caption)
            .padding()
            
//            Map(coordinateRegion: $mapRegion)
            
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
//
//    //            MapMarker(coordinate: location.coordinate)
//
                MapAnnotation(coordinate: location.coordinate) {
                    Image(systemName: "house.circle")
                        .foregroundColor(.red)
                        .font(.title)

                }
//
//    //            MapAnnotation(coordinate: location.coordinate) {
//    //                Circle()
//    //                    .stroke(.red, lineWidth: 3)
//    //                    .frame(width: 44, height: 44)
//    //                    .onTapGesture {
//    //                                print("Tapped on \(location.name)")
//    //                            }
//    //            }
//
//    //            NavigationView {
//    //                Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
//    //                    MapAnnotation(coordinate: location.coordinate) {
//    //                        NavigationLink {
//    //                            Text(location.name)
//    //                        } label: {
//    //                            Circle()
//    //                                .stroke(.red, lineWidth: 3)
//    //                                .frame(width: 44, height: 44)
//    //                        }
//    //                    }
//    //                }
//    //                .navigationTitle("London Explorer")
//    //            }
//
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
