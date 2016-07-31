//
//  Helper.swift
//  MillionHairs
//
//  Created by TwoStraws on 18/07/2016.
//  Copyright © 2016 Paul Hudson. All rights reserved.
//

import Cocoa

class Helper: NSObject {
	static func getPathInDocumentsDirectory(path: String) -> NSURL {
		let paths = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory,	inDomains: .UserDomainMask)
		let documentsDirectory = paths[0]
		let newPath = documentsDirectory.URLByAppendingPathComponent(path)
		return newPath
	}
}
