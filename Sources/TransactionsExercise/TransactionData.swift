import Foundation

public struct TransactionData {

    /// The unique identifier for this transaction
    public let id: String

    /// The type of transaction.
    public let type: TransactionType

    /// Timestamp when this transaction was processed.
    ///
    /// Format is ISO-8601, e.g., "2025-12-09T10:16:00Z"
    public let createdAt: Date

    /// The title of the transaction.
    public let title: String

    /// The amount of the transaction.
    ///
    /// Amounts will always be positive numbers.
    public let amount: Double
}

public enum TransactionType: CaseIterable {
    case regular
    case income
}
