import Foundation

extension Sequence {
  /// Returns the elements of the sequence, sorted using the ``Comparable`` value of the given keypath.
  public func sorted(byKeyPath keyPath: KeyPath<Element, some Comparable>) -> [Self.Element] {
    self.sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
  }
}
