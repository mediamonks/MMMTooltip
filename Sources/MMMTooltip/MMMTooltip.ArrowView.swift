//
// MMMTooltip. Part of MMMTemple suite.
// Copyright (C) 2016-2022 MediaMonks. All rights reserved.
//

import UIKit

extension MMMTooltip {
	
	internal final class ArrowView: UIView {
		
		public override class var layerClass: AnyClass { CAShapeLayer.self }
		private var _layer: CAShapeLayer { layer as! CAShapeLayer }
		
		private let style: Style
		
		public init(style: Style) {
			
			self.style = style
			
			super.init(frame: .zero)
			
			let size = style.arrowSize
			
			self.translatesAutoresizingMaskIntoConstraints = false
			self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
			self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
			
			self._layer.fillColor = style.backgroundColor.cgColor
			
			let topY = style.location.isTop ? 0 : size.height
			let bottomY = style.location.isTop ? size.height : 0
			let radiusY = style.location.isTop ?
				topY + (style.arrowRadius / 2) :
				topY - (style.arrowRadius / 2)
			
			let path = UIBezierPath()
			path.move(to: CGPoint(x: 0, y: bottomY))
			path.addLine(
				to: CGPoint(
					x: (size.width / 2) - (style.arrowRadius / 2),
					y: radiusY
				)
			)
			
			path.addQuadCurve(
				to: CGPoint(
					x: (size.width / 2) + (style.arrowRadius / 2),
					y: radiusY
				),
				controlPoint: CGPoint(
					x: (size.width / 2),
					y: topY
				)
			)
			
			path.addLine(to: CGPoint(x: size.width, y: bottomY))
			path.addLine(to: CGPoint(x: 0, y: bottomY))
			
			self._layer.path = path.cgPath
		}
		
		@available(*, unavailable)
		internal required init?(coder: NSCoder) {
			fatalError("\(#function) has not been implemented")
		}
	}
}
