//===--- GCD.swift --------------------------------------------*- swift -*-===//
//
// This source file is part of the Swift Numerics open source project
//
// Copyright (c) 2021 Apple Inc. and the Swift Numerics project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

extension BinaryInteger {
  
  /// The greatest common divisor of `a` and `b`.
  ///
  /// If both inputs are zero, the result is zero.
  @inlinable
  public static func gcd(_ a: Self, _ b: Self) -> Self {
    var x = a.magnitude
    var y = b.magnitude
    
    if x == 0 { return Self(y) }
    if y == 0 { return Self(x) }
    
    let xtz = x.trailingZeroBitCount
    let ytz = y.trailingZeroBitCount
    
    x >>= xtz
    y >>= ytz
    
    // The binary GCD algorithm
    //
    // At the top of the loop both x and y are odd. Each pass removes at least
    // one low-order bit from the larger of the two, so the number of iterations
    // is bounded by the sum of the bit-widths of the inputs.
    while x != 0 {
      if x < y { swap(&x, &y) }
      x -= y
      x >>= x.trailingZeroBitCount
    }
    
    return Self(y << min(xtz, ytz))
  }
}
