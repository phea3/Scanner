// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class QrCodeCheckAttendanceMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation QrCodeCheckAttendance($idCard: String!) {
      qrCodeCheckAttendance(IdCard: $idCard) {
        __typename
        message
        status
      }
    }
    """

  public let operationName: String = "QrCodeCheckAttendance"

  public var idCard: String

  public init(idCard: String) {
    self.idCard = idCard
  }

  public var variables: GraphQLMap? {
    return ["idCard": idCard]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("qrCodeCheckAttendance", arguments: ["IdCard": GraphQLVariable("idCard")], type: .nonNull(.object(QrCodeCheckAttendance.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(qrCodeCheckAttendance: QrCodeCheckAttendance) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "qrCodeCheckAttendance": qrCodeCheckAttendance.resultMap])
    }

    public var qrCodeCheckAttendance: QrCodeCheckAttendance {
      get {
        return QrCodeCheckAttendance(unsafeResultMap: resultMap["qrCodeCheckAttendance"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "qrCodeCheckAttendance")
      }
    }

    public struct QrCodeCheckAttendance: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["ResponseMessage"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("message", type: .scalar(String.self)),
          GraphQLField("status", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(message: String? = nil, status: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "ResponseMessage", "message": message, "status": status])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

      public var status: Bool? {
        get {
          return resultMap["status"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }
    }
  }
}
