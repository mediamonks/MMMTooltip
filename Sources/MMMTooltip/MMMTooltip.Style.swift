//
// MMMTooltip. Part of MMMTemple suite.
// Copyright (C) 2016-2022 MediaMonks. All rights reserved.
//

import UIKit

extension MMMTooltip {
	
	public struct Style {
		
		public enum Location {
			case topLeading, bottomLeading
			case topCenter, bottomCenter
			case topTrailing, bottomTrailing
			
			internal var isTop: Bool {
				switch self {
				case .topLeading, .topCenter, .topTrailing: return true
				case .bottomLeading, .bottomCenter, .bottomTrailing: return false
				}
			}
		}
		
		/// Determines the location of the tooltip arrow as well as where the tooltip will appear. For instance, on a
		/// ``Location/topLeading`` location, the tooltip will appear below the `targetView`, with the arrow
		/// on the top leading side. Whereas on a ``Location/bottomCenter`` location, the toolltip will appear
		/// above the `targetView` with the arrow on the bottom center.
		public let location: Location
		
		/// The amount we offset the tooltip from the `targetView`, 
		public let offset: CGFloat
		
		/// The amount of padding that the tooltip should use when positioning itself in the superview, so it doesn't hug
		/// the screen edges.
		public let padding: CGFloat
		
		/// The background color of the tooltip and arrow.
		public let backgroundColor: UIColor
		
		/// The radius of the tooltip.
		public let cornerRadius: CGFloat
		
		/// The radius of the arrow. Where `0` would be a sharp rectangle.
		public let arrowRadius: CGFloat
		
		/// The size of the arrow.
		public let arrowSize: CGSize
		
		/// How much we should inset the `contentView`.
		public let contentInsets: UIEdgeInsets
		
		/// How much we should inset the `buttonView`.
		public let buttonInsets: UIEdgeInsets
		
		/// How much the arrow and tooltip should try to add as padding. For example on a `topLeading` location,
		/// you usually don't want the arrow & tooltip all the way on the left. Setting this to `0.3` for instance, will place
		/// the arrow at 30% of the width of the tooltip.
		public let preferredPaddingMultiplier: CGFloat
		
		/// How hard we should try to stick to the ``preferredPaddingMultiplier``.
		public let preferredPaddingPriority: UILayoutPriority
		
		/// How wide the tooltip can get according to the superview. This is a multiplier, so at `1.0` the tooltip will take
		/// up all the available space in the `superview` of the `targetView`, whereas with `0.5` the tooltip will
		/// never get bigger than half the size of the `superview`.
		public let maxWidthMultiplier: CGFloat
		
		public init(
			location: Location,
			offset: CGFloat = 8,
			padding: CGFloat = 16,
			backgroundColor: UIColor = .black,
			cornerRadius: CGFloat = 8,
			arrowRadius: CGFloat = 4,
			arrowSize: CGSize = CGSize(width: 12, height: 8),
			contentInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16),
			buttonInsets: UIEdgeInsets = .zero,
			preferredPaddingMultiplier: CGFloat = 0.17,
			preferredPaddingPriority: UILayoutPriority = .defaultHigh,
			maxWidthMultiplier: CGFloat = 0.75
		) {
			self.location = location
			self.offset = offset
			self.padding = padding
			self.backgroundColor = backgroundColor
			self.cornerRadius = cornerRadius
			self.arrowRadius = arrowRadius
			self.arrowSize = arrowSize
			self.contentInsets = contentInsets
			self.buttonInsets = buttonInsets
			self.preferredPaddingMultiplier = preferredPaddingMultiplier
			self.preferredPaddingPriority = preferredPaddingPriority
			self.maxWidthMultiplier = maxWidthMultiplier
		}
	}
}
