import Foundation
import PathKit
import ProjectSpec
import XcodeGenKit
import XcodeProj
import XCTest

//class GeneratedPerformanceTests: XCTestCase {
//
//    let basePath = Path.temporary + "XcodeGenPeformanceTests"
//
//    func testLoading() throws {
//        let project = try Project.testProject(basePath: basePath)
//        let specPath = basePath + "project.yaml"
//        try dumpYamlDictionary(project.toJSONDictionary(), path: specPath)
//
//        measure {
//            let spec = try! SpecFile(path: specPath,
//                                     variables: ProcessInfo.processInfo.environment)
//            _ = spec.resolvedDictionary()
//        }
//    }
//
//    func testGeneration() throws {
//        let project = try Project.testProject(basePath: basePath)
//        measure {
//            let generator = ProjectGenerator(project: project)
//            _ = try! generator.generateXcodeProject(userName: "someUser")
//        }
//    }
//
//    func testWriting() throws {
//        let project = try Project.testProject(basePath: basePath)
//        let generator = ProjectGenerator(project: project)
//        let xcodeProject = try generator.generateXcodeProject(userName: "someUser")
//        measure {
//            xcodeProject.pbxproj.invalidateUUIDs()
//            try! xcodeProject.write(path: project.defaultProjectPath)
//        }
//    }
//}

let fixturePath = Path(#file).parent().parent() + "Fixtures"

//class FixturePerformanceTests: XCTestCase {
//
//    let specPath = fixturePath + "TestProject/project.yml"
//
//    func testFixtureDecoding() async throws {
//        measure {
//            _ = try! await Project(path: specPath)
//        }
//    }
//
//    func testCacheFileGeneration() async throws {
//        let specLoader = SpecLoader(version: "1.2")
//        _ = try await specLoader.loadProject(path: specPath)
//
//        measure {
//            _ = try! specLoader.generateCacheFile()
//        }
//    }
//
//    func testFixtureGeneration() async throws {
//        let project = try await Project(path: specPath)
//        measure {
//            let generator = ProjectGenerator(project: project)
//            _ = try! generator.generateXcodeProject(userName: "someUser")
//        }
//    }
//
//    func testFixtureWriting() async throws {
//        let project = try await Project(path: specPath)
//        let generator = ProjectGenerator(project: project)
//        let xcodeProject = try generator.generateXcodeProject(userName: "someUser")
//        measure {
//            xcodeProject.pbxproj.invalidateUUIDs()
//            try! xcodeProject.write(path: project.defaultProjectPath)
//        }
//    }
//}
