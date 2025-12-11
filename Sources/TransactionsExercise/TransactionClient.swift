import Foundation

public protocol TransactionClient: Sendable {

    /// Fetch a page of transactions
    ///
    /// - Parameters:
    ///   - cursor: The position in the search results to fetch from next. If nil, starts from the beginning.
    ///   - size: The number of records to fetch.
    func listTransactions(after cursor: String?) async throws -> ListTransactionsResponse
}

public struct TransactionClientError: Error {}

// MARK: - MockTransactionClient

public struct MockTransactionClient: TransactionClient {

    private let startDate = ISO8601DateFormatter().date(from: "2025-07-01T00:00:00Z")!

    public init() {}

    public func listTransactions(
        after cursor: String?,
    ) async throws -> ListTransactionsResponse {
        let dateFormatter = ISO8601DateFormatter()

        var date =
            cursor.flatMap { cursor in
                let encodedData = cursor.data(using: .utf8)!

                return if let data = Data(base64Encoded: encodedData) {
                    dateFormatter.date(from: String(data: data, encoding: .utf8)!)
                } else {
                    nil
                }
            } ?? Date()

        guard date > startDate else { return .empty }

        var items: [TransactionData] = []

        for _ in 0..<20 {
            let transaction = makeRandomTransaction(before: date)
            date = ISO8601DateFormatter().date(from: transaction.createdAt)!

            guard date > startDate else { break }
            items.append(transaction)
        }

        let cursor = ISO8601DateFormatter()
            .string(from: date)
            .data(using: .utf8)!
            .base64EncodedString()

        return ListTransactionsResponse(
            items: items,
            cursor: cursor,
        )
    }
}

private func makeRandomTransaction(before date: Date) -> TransactionData {

    let type = ["regular", "income"].randomElement()!

    let createdAt =
        ISO8601DateFormatter()
        .string(
            from: date.addingTimeInterval(
                // Randomly moved back between an hour and a week
                -Double.random(in: 3600...604_800)
            )
        )

    let title =
        switch type {
        case "income":
            "Payroll"

        case "regular": fallthrough
        default:
            [
                "Lyft",
                "Cardozo's Pub",
                "BP Gas",
                "Kroger",
                "Walgreens",
                "The Knick-Knackery",
                "LAZ Parking",
                "ComEd",
            ].randomElement()!

        }

    let amount =
        switch type {
        case "regular": Double(Int.random(in: 1...9_999_99)) / 100.0
        case "income": Double(Int.random(in: 1...9_999_99)) / 100.0
        default: 42.0
        }

    return TransactionData(
        type: type,
        createdAt: createdAt,
        title: title,
        amount: amount
    )
}
