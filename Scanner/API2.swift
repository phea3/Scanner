// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public struct TeacherAnntendanceInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - date
  ///   - teacherId
  ///   - remark
  ///   - status
  public init(date: Swift.Optional<String?> = nil, teacherId: Swift.Optional<GraphQLID?> = nil, remark: Swift.Optional<String?> = nil, status: Swift.Optional<String?> = nil) {
    graphQLMap = ["date": date, "teacherId": teacherId, "remark": remark, "status": status]
  }

  public var date: Swift.Optional<String?> {
    get {
      return graphQLMap["date"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "date")
    }
  }

  public var teacherId: Swift.Optional<GraphQLID?> {
    get {
      return graphQLMap["teacherId"] as? Swift.Optional<GraphQLID?> ?? Swift.Optional<GraphQLID?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "teacherId")
    }
  }

  public var remark: Swift.Optional<String?> {
    get {
      return graphQLMap["remark"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "remark")
    }
  }

  public var status: Swift.Optional<String?> {
    get {
      return graphQLMap["status"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "status")
    }
  }
}

public final class CreateTeacherAttendanceMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation CreateTeacherAttendance($teacherCardId: ID, $newData: TeacherAnntendanceInput) {
      createTeacherAttendance(teacherCardId: $teacherCardId, newData: $newData) {
        __typename
        success
        message
      }
    }
    """

  public let operationName: String = "CreateTeacherAttendance"

  public var teacherCardId: GraphQLID?
  public var newData: TeacherAnntendanceInput?

  public init(teacherCardId: GraphQLID? = nil, newData: TeacherAnntendanceInput? = nil) {
    self.teacherCardId = teacherCardId
    self.newData = newData
  }

  public var variables: GraphQLMap? {
    return ["teacherCardId": teacherCardId, "newData": newData]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("createTeacherAttendance", arguments: ["teacherCardId": GraphQLVariable("teacherCardId"), "newData": GraphQLVariable("newData")], type: .object(CreateTeacherAttendance.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createTeacherAttendance: CreateTeacherAttendance? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createTeacherAttendance": createTeacherAttendance.flatMap { (value: CreateTeacherAttendance) -> ResultMap in value.resultMap }])
    }

    public var createTeacherAttendance: CreateTeacherAttendance? {
      get {
        return (resultMap["createTeacherAttendance"] as? ResultMap).flatMap { CreateTeacherAttendance(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createTeacherAttendance")
      }
    }

    public struct CreateTeacherAttendance: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Response"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("success", type: .scalar(Bool.self)),
          GraphQLField("message", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(success: Bool? = nil, message: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Response", "success": success, "message": message])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var success: Bool? {
        get {
          return resultMap["success"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }

      public var message: String? {
        get {
          return resultMap["message"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }
    }
  }
}
