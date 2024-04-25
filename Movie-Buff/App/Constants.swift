//
//  URLUtils.swift
//  Movie-Buff
//
//  Created by Mohak Tamhane on 4/18/24.
//

import Foundation
import SwiftUI

enum Constants {
    enum URLs {
        public static let baseURL = "https://api.themoviedb.org/3"

        // swiftlint:disable:next line_length
        public static let upcoming = baseURL + "/discover/movie?include_adult=false&include_video=false&language=en-US&page=1"
        public static let releaseDateGTE = "&primary_release_date.gte="
        public static let releaseDateLTE = "&primary_release_date.lte="
        public static let sortUpcoming = "&sort_by=popularity.desc&with_release_type=2&year="

        public static let genres = baseURL + "/genre/movie/list?language=en"
        public static let trending = baseURL + "/trending/movie/day?language=en-US"
        public static let topRated = baseURL + "/movie/top_rated?language=en-US&page=1"
        public static let nowPlaying = baseURL + "/movie/now_playing?language=en-US&page=1"

        // swiftlint:disable:next line_length
        public static let trendBollywood = baseURL + "/discover/movie?include_adult=false&include_video=false&language=hi-IN"
        public static let primaryReleaseYearBollywood = "&page=1&primary_release_year="
        public static let sortBollywood = "&sort_by=popularity.desc&with_original_language=hi"

        public static let popularPerson = baseURL + "/person/popular?language=en-US&page=1"
    }
}

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertMessage {
    static let invalidData = AlertItem(title: Text("Server Error"),
                                       // swiftlint:disable:next line_length
                                   message: Text("The data receive from the server was invalid, Please contact support."),
                                   dismissButton: .default(Text("OK")))

    static let invalidResponse = AlertItem(title: Text("Server Error"),
                                           // swiftlint:disable:next line_length
                                       message: Text("Invalid response from the server. Please try again later or contact support."),
                                       dismissButton: .default(Text("OK")))

    static let invalidURL = AlertItem(title: Text("Server Error"),
                                      // swiftlint:disable:next line_length
                                  message: Text("There was connecting issue to the server. If this persists, Please contact support."),
                                  dismissButton: .default(Text("OK")))

    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                            // swiftlint:disable:next line_length
                                        message: Text("Unable to complete your request this time. Please check you network."),
                                        dismissButton: .default(Text("OK")))

    static let invalidForm = AlertItem(title: Text("Form not complete"),
                                   message: Text("Please fill all the info."),
                                   dismissButton: .default(Text("OK")))

    static let invalidEmail = AlertItem(title: Text("Form not complete"),
                                    message: Text("Email invalid."),
                                    dismissButton: .default(Text("OK")))

    static let userSaveSuccess = AlertItem(title: Text("Profile"),
                                       message: Text("Your Information was successfully done."),
                                       dismissButton: .default(Text("OK")))

    static let invalidUserData = AlertItem(title: Text("Profile"),
                                       message: Text("Your Information save/retrieve process can't be done."),
                                       dismissButton: .default(Text("OK")))

    static let GeneralError = AlertItem(title: Text("Willy Nilly"),
                                    message: Text("Something wrong with the data.\nPlease contact support."),
                                    dismissButton: .default(Text("OK")))
}
