//
//  WarInfoNetworkingTests.swift
//  WarStatTests
//
//  Created by a.antoniak on 04.12.2023.
//

import XCTest
@testable import WarStat

final class WarInfoNetworkingTests: XCTestCase {
    var sut: WarInfoNetworking.Type?
    var warInfoResult: InfoResult?
    
    override func setUpWithError() throws {
        super.setUp()
    }
    
    override func tearDownWithError() throws {
        warInfoResult = nil
        super.tearDown()
    }
    
    func testLoadInfoDTO() async {
        givenUserIsOnTheWarInfoScreen()
        await whenUserTapsOnLoadWarInfo()
        await thenUserShouldSeeWarInfo()
    }
}

extension WarInfoNetworkingTests {
    func givenUserIsOnTheWarInfoScreen() {
        sut = WarInfoNetworking.self
    }
    
    func whenUserTapsOnLoadWarInfo() async {
        warInfoResult = await sut?.loadInfo()
    }
    
    func thenUserShouldSeeWarInfo() async {
        if case let .failure(error) = warInfoResult {
            XCTFail("Load info should return success with war info DTO, but returned failure with error(\(error.localizedDescription)")
        }
    }
}
