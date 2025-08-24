//
//  AgeFormatterService.swift
//  HappyBirthdayApp
//
//  Created by Viktor Vilkhovyi on 24.08.2025.
//

import Foundation

protocol IAgeFormatting {
    func ageComponents(from birthday: Date, now: Date) -> AgeFormatterService.Components?
    func formattedAge(from birthday: Date, now: Date, mode: AgeFormatterService.Mode) -> String
}

struct AgeFormatterService: IAgeFormatting {
    
    enum Unit {
        case month, year
        
        func label(for value: Int) -> String {
            switch self {
            case .year:  return value == 1 ? "year" : "years"
            case .month: return value == 1 ? "month" : "months"
            }
        }
    }
    
    struct Components {
        let value: Int          // e.g. 3
        let unit: Unit          // .month or .year
        var unitLabel: String { unit.label(for: value) }
    }
    
    enum Mode {
        /// Full descriptive text: "1 month old", "3 years old"
        case full
        
        /// Just the number + unit: "1 month", "3 years"
        case short
        
        /// Only the unit: "month", "months", "year", "years"
        case unitOnly
        
        /// Only the numeric value as String: "1", "3"
        case numberOnly
    }
    
    private let calendar: Calendar

    init(calendar: Calendar = .current) {
        self.calendar = calendar
    }

    func formattedAge(from birthday: Date, now: Date = .now, mode: Mode = .full) -> String {
        let components = calendar.dateComponents([.year, .month], from: birthday, to: now)
        
        if let years = components.year, years >= 1 {
            return formatValue(years, singular: "year", plural: "years", mode: mode)
        }
        
        if let months = components.month, months >= 1 {
            return formatValue(months, singular: "month", plural: "months", mode: mode)
        }
        
        return "Newborn"
    }
    
    private func formatValue(_ value: Int, singular: String, plural: String, mode: Mode) -> String {
        switch mode {
        case .full:
            return value == 1 ? "1 \(singular) old" : "\(value) \(plural) old"
        case .short:
            return value == 1 ? "1 \(singular)" : "\(value) \(plural)"
        case .unitOnly:
            return value == 1 ? singular : plural
        case .numberOnly:
            return "\(value)"
        }
    }
    
    func ageComponents(from birthday: Date, now: Date = .now) -> Components? {
        let components = calendar.dateComponents([.year, .month], from: birthday, to: now)
        
        if let years = components.year, years >= 1 {
            return Components(value: years, unit: .year)
        }
        
        if let months = components.month, months >= 1 {
            return Components(value: months, unit: .month)
        }
        
        return nil
    }
}
