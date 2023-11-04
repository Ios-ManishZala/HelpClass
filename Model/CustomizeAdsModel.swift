
import Foundation

// MARK: - Welcome
struct CustomizeAds: Codable {
    let status: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let isAdOn, isCustomAdsOn: Int
    let name, bundleID, forceUpdateVersion, liveVersion: String
    let intertialGapCount, intertialInitialCount: Int
    let subscription1, subscription2, subscription3, subscription4: String
    let subscription5: String
    let google, facebook: Google
    let myads: Myads
    let native_color_code : String
    
    enum CodingKeys: String, CodingKey {
        case isAdOn = "is_ad_on"
        case isCustomAdsOn = "is_custom_ads_on"
        case name
        case bundleID = "bundle_id"
        case forceUpdateVersion = "force_update_version"
        case liveVersion = "live_version"
        case intertialGapCount = "intertial_gap_count"
        case intertialInitialCount = "intertial_initial_count"
        case subscription1, subscription2, subscription3, subscription4, subscription5
        case google = "Google"
        case facebook, myads , native_color_code
    }
}

// MARK: - Google
struct Google: Codable {
    let nativeAds, interstitialAds, bannerAds, addOpenAds: String
    let rewardedAds: String
}

// MARK: - Myads
struct Myads: Codable {
    let appIcon, description, link, title: String
    let appList: [AppList]

    enum CodingKeys: String, CodingKey {
        case appIcon = "app_icon"
        case description, link, title, appList
    }
}

// MARK: - AppList
struct AppList: Codable {
    let appImage: String
    let appIcon: String
    let title, description: String
    let link: String
}
