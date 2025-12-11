public struct TransactionData {

    /// The unique identifier for this transaction
    public let id: String

    /// The type of transaction.
    ///
    /// Should be one of "regular" or "income"
    public let type: String

    /// Timestamp when this transaction was processed.
    ///
    /// Format is ISO-8601, e.g., "2025-12-09T10:16:00Z"
    public let createdAt: String

    /// The title of the transaction.
    public let title: String

    /// The amount of the transaction
    public let amount: Double
}
