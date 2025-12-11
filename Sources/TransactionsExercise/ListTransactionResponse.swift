public struct ListTransactionsResponse {
    public let items: [TransactionData]

    /// A cursor to fetch the next page.
    ///
    /// If nil, there are no more pages to fetch.
    public let cursor: String?
}

extension ListTransactionsResponse {
    public static var empty: Self {
        ListTransactionsResponse(items: [], cursor: nil)
    }
}
