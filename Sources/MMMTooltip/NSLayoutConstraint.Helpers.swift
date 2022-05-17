//
// MMMTooltip. Part of MMMTemple suite.
// Copyright (C) 2016-2022 MediaMonks. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
	
	internal convenience init(
		item view1: Any,
		attribute attr1: NSLayoutConstraint.Attribute,
		relatedBy relation: NSLayoutConstraint.Relation,
		toItem view2: Any?,
		attribute attr2: NSLayoutConstraint.Attribute,
		multiplier: CGFloat = 1,
		constant c: CGFloat = 0,
		priority: UILayoutPriority = .required
	) {
		self.init(
			item: view1,
			attribute: attr1,
			relatedBy: relation,
			toItem: view2,
			attribute: attr2,
			multiplier: multiplier,
			constant: c
		)
		
		self.priority = priority
	}
}
