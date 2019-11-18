//
//  NativeObject.swift
//  LispKit
//
//  Created by Matthias Zenger on 18/11/2019.
//  Copyright © 2019 ObjectHub. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation

///
/// `NativeObject` is the superclass of all native object types. This class needs to be
/// subclassed to implement custom object types in LispKit.
///
open class NativeObject: Reference {
  open var type: Type {
    preconditionFailure("NativeObject.type undefined: NativeObject instantiated")
  }

  open var string: String {
    return "#<\(self.type) \(self.identityString)>"
  }

  open var hash: Int {
    return self.hashValue
  }

  open func equals(_ obj: NativeObject) -> Bool {
    return self === obj
  }

  public override var typeDescription: String {
    return self.type.description
  }
}

///
/// `AnyNativeObject` can be used as a wrapper for native objects not derived from
/// class `NativeObject`.
///
public class AnyNativeObject<T: Hashable>: NativeObject {
  public let value: T

  public init(_ value: T) {
    self.value = value
  }

  public override var hash: Int {
    return self.value.hashValue
  }

  public override func equals(_ obj: NativeObject) -> Bool {
    guard let other = obj as? AnyNativeObject<T> else {
      return false
    }
    return self.value == other.value
  }
}
