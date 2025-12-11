//
//  Harness.swift
//  MockTransactionClient
//
//  Created by Joel McCance on 12/9/25.
//

import TransactionsExercise

@main
struct App {
    static func main() async {
        let client: TransactionClient = MockTransactionClient()

        do {
            var response: ListTransactionsResponse = .empty
            var cursor: String? = nil

            repeat {
                response = try await client.listTransactions(after: cursor)
                cursor = response.cursor


                for item in response.items {
                    print(item)
                }

                guard response.items.count > 0 else { break }
                print("-----")
            } while cursor != nil
        } catch {

        }
    }
}
