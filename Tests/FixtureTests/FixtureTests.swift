import PathKit
import ProjectSpec
import Spectre
import XcodeGenKit
import XcodeProj
import XCTest
import TestSupport

class FixtureTests: XCTestCase {

//    func testProjectFixture() async {
//        describe {
//            $0.it("generates Test Project") {
//                try await generateXcodeProject(specPath: fixturePath + "TestProject/AnotherProject/project.yml")
//                try await generateXcodeProject(specPath: fixturePath + "TestProject/project.yml")
//            }
//            $0.it("generates Carthage Project") {
//                try await generateXcodeProject(specPath: fixturePath + "CarthageProject/project.yml")
//            }
//            $0.it("generates SPM Project") {
//                try await generateXcodeProject(specPath: fixturePath + "SPM/project.yml")
//            }
//        }
//    }
}

private func generateXcodeProject(specPath: Path, file: String = #file, line: Int = #line) async throws {
    let project = try await Project(path: specPath)
    let generator = ProjectGenerator(project: project)
    let writer = FileWriter(project: project)
    let xcodeProject = try await generator.generateXcodeProject(userName: "someUser")
    try writer.writeXcodeProject(xcodeProject)
    try writer.writePlists()
}
