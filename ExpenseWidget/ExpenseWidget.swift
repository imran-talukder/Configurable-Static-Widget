//
//  ExpenseWidget.swift
//  ExpenseWidget
//
//  Created by Appnap WS01 on 19/10/20.
//

import WidgetKit
import SwiftUI

struct IntentProvider: IntentTimelineProvider {
    
    typealias Intent = ViewMonthlyExpenseIntent
    public typealias Entry = ExpenseEntry

    func placeholder(in context: Context) -> Entry {
        ExpenseEntry(category: ExpenseCategory.all)
    }

    
    func getSnapshot(for configuration: Intent, in context: Context, completion: @escaping (Entry) -> Void) {
        let entry = ExpenseEntry(category: ExpenseCategory.all)
        completion(entry)
    }
    
    func getTimeline(for configuration: Intent, in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        print("You clicked \(configuration.expenseparameter.rawValue)")
        let entry = ExpenseEntry(category: ExpenseCategory(rawValue: configuration.expenseparameter.rawValue) ?? .all)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
    
}

struct ExpenseEntry: TimelineEntry {
    public let date = Date()
    public let category: ExpenseCategory
    
}

public enum ExpenseCategory: Int {
    
    case all = 1, food, gas, grocery, rent
    
}


struct WidgetEntryView: View {
    var entry: ExpenseEntry
    
    var body: some View {
            ExpenseView(category: entry.category)
    }
}


struct ExpenseView: View {
    var category: ExpenseCategory
    var body: some View {
        switch category {
        case .all:
            ZStack {
                Color.red.opacity(1.0)
                VStack {
                    Text("All Expense")
                }
            }
        case .food:
            ZStack {
                Color.green.opacity(1.0)
                VStack {
                    Text("Food Expense")
                }
            }
        case .gas:
            ZStack {
                Color.blue.opacity(1.0)
                VStack {
                    Text("Gas Expense")
                }
            }
        case .grocery:
            ZStack {
                Color.black.opacity(1.0)
                VStack {
                    Text("Grocery Expense")
                        .foregroundColor(.white)
                }
            }
        case .rent:
            ZStack {
                Color.yellow.opacity(1.0)
                VStack {
                    Text("Rent Expense")
                }
            }
        }
    }
}


@main
struct ExpenseWidget: Widget {
    private let kind = "ExpenseWidget"
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: "ExpenseWidget", intent: ViewMonthlyExpenseIntent.self, provider: IntentProvider()) { entry in
            WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Expense Widget")
    }
}
