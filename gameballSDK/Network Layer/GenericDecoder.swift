//
//  GenericDecoder.swift
//  gameball_SDK
//
//  Created by Ahmed Abodeif on 2/4/19.
//  Copyright © 2019 Ahmed Abodeif. All rights reserved.
//

import Foundation

open class GenericDecoder<IN, OUT: Codable> {
    public class func decode(_  Data: IN) -> OUT? {
        fatalError("This method is empty please implement it on a subclass")
    }
}


class GenericJSONDecoder<IN, OUT: Codable> : GenericDecoder<IN, OUT> {
    public override class func decode(_ inObject: IN) -> OUT? {
        //This is where the magic hapens,
        //and we go from the json to the OUT class
        return try? JSONDecoder().decode(OUT.self, from: inObject as! Data)
    }
}
