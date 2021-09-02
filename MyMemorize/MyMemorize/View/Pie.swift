//
//  Pie.swift
//  MyMemorize
//
//  Created by Alex on 02.09.2021.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise = false
    
    func path(in rect: CGRect) -> Path {
        
        let centet = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: centet.x + radius * CGFloat(cos(startAngle.radians)),
            y: centet.y + radius * CGFloat(sin(startAngle.radians))
        )
        
        var p = Path()
        p.move(to: centet)
        p.addLine(to: start)
        p.addArc(center: centet, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
        p.addLine(to: centet)
        
        return p
    }
}
