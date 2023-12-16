//
//  WarInfoNetworkingIntegrationTests.swift
//  WarStatTests
//
//  Created by a.antoniak on 04.12.2023.
//

import XCTest
@testable import WarStat

final class WarInfoNetworkingIntegrationTests: XCTestCase {
    override func setUpWithError() throws {
        super.setUp()
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testLoadInfo() async {
        // Given
        let sut = WarInfoNetworking.self
        
        // When
        async let result = sut.loadInfo()
        
        // Then
        if case let .failure(error) = await result {
            XCTFail("Load info should return success with war info DTO, but returned failure with error(\(error.localizedDescription)")
        }
    }
}
