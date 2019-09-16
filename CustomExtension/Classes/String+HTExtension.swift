//
//  String+HTExtension.swift
//  Hanten-iOSExtensions
//
//  Created by huangzhiqiang on 2019/9/7.
//

import CommonCrypto
import Foundation


// MARK: - 类型转换
extension String {
    
    func intValue() -> Int {
        return NSString(string: self).integerValue
    }
    
    func boolValue() -> Bool {
        return NSString(string: self).boolValue
    }
    
    func doubleValue() -> Double {
        return NSString(string: self).doubleValue
    }
    
    func floatValue() -> Float {
        return NSString(string: self).floatValue
    }
    
    /// 转换URL 已对特殊字符做编码
    ///
    /// - Returns: URL
    func urlValue() -> URL? {
        let urlStr = self.encodingUrlStr()
        let url = URL.init(string: urlStr)
        return url
    }
    
    /// 对特殊字符串和汉字做编码
    ///
    /// - Parameter lose: 不做编码的字符串
    /// - Returns: 编码后的字符串
    func encodingUrlStr(_ lose: String? = "") -> String {
        let charSet = NSMutableCharacterSet()
        charSet.formUnion(with: CharacterSet.urlQueryAllowed)
        if lose != nil && lose!.count != 0{
            charSet.addCharacters(in: lose!)
        }
        let urlStr = self.addingPercentEncoding(withAllowedCharacters: charSet as CharacterSet)
        return urlStr ?? ""
    }
}

// MARK: - 常用判断
extension String {
    
    /// 是否空字符串
    func isEmpty() -> Bool {
        if isEmpty {
            return true
        } else {
            let set: CharacterSet = CharacterSet.whitespacesAndNewlines
            let trimedString: String = trimmingCharacters(in: set)
            return trimedString.count == 0
        }
    }
    
    /// 是否是邮箱
    func validateEmail(candidate: String) -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    /// 是否是数字
    func isNumber() -> Bool {
        let matchStr: String = "^[0-9]{\(count)}$"
        let pre: NSPredicate = NSPredicate(format: "SELF MATCHES %@", matchStr)
        return pre.evaluate(with: self)
    }
    
    /// 是否是中文
    func isMatchChinese() -> Bool {
        let matchStr: String = "^[一-龥]+$"
        let pre: NSPredicate = NSPredicate(format: "SELF MATCHES %@", matchStr)
        return pre.evaluate(with: self)
    }
    
    /// 是否是正式的身份证
    func isTrueIdCard() -> Bool {
        let matchStr: String = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        let pre: NSPredicate = NSPredicate(format: "SELF MATCHES %@", matchStr)
        return pre.evaluate(with: self)
    }
    
}


// MARK: - 字符串加密
extension String {
    
    /// SHA1加密
    func sha1() -> String {
        if isEmpty() { return "" }
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_SHA1_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_SHA1(str!, strLen, result)
        
        return stringFromBytes(bytes: result, length: digestLen)
    }
    
    /// MD5加密
    func md5() -> String {
        if isEmpty() { return "" }
        let str = self.self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        
        return stringFromBytes(bytes: result, length: digestLen)
    }
    
    func stringFromBytes(bytes: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", bytes[i])
        }
        bytes.deallocate()
        return String(format: hash as String)
    }
    
}
