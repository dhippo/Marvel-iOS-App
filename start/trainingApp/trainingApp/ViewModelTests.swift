//
//  ViewModelTests.swift
//  trainingAppTests
//
//  Created by reda.mimouni.ext on 27/10/2023.
//

import XCTest
@testable import trainingApp

class ViewModelTests: XCTestCase {

    func test_onClick_should_return_true() {
        let viewModel = ViewModel()

        let result = viewModel.onClick(login: "JOHN DOE", password: "OMNES")

        XCTAssertTrue(result)
    }

    func test_onClick_should_return_false() {
        let viewModel = ViewModel()

        let result = viewModel.onClick(login: "", password: "")

        XCTAssertFalse(result)
    }


}
