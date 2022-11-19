//
//  CustomAnnotationView.swift
//  SeSAC Service Level Project
//
//  Created by 이명진 on 2022/11/19.
//

import UIKit
import MapKit

final class CustomAnnotationView: MKAnnotationView {
    
    static let identifier = "CustomAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

final class CustomAnnotation: NSObject, MKAnnotation {
    
    let sesacImage: Int?
    let coordinate: CLLocationCoordinate2D
    
    init(sesacImage: Int?, coordinate: CLLocationCoordinate2D) {
        self.sesacImage = sesacImage
        self.coordinate = coordinate
        super.init()
    }
    
}
