//
// MMMTooltip. Part of MMMTemple suite.
// Copyright (C) 2016-2022 MediaMonks. All rights reserved.
//

import UIKit

extension MMMTooltip {
	
	public enum Dismissal {
		/// We don't dismiss the tooltip at all. You have to do it yourself by calling `.dismiss()` on the tooltip.
		case none
		/// Automatically dismiss the tooltip after a given interval.
		case timer(interval: TimeInterval)
		/// Dismisss the tooltip when the attached button/`UIControl` receives a given event.
		case buttonEvent(event: UIControl.Event)
	}
}
