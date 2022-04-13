Pod::Spec.new do |spec|

  spec.name         = "Jasmine"
  spec.version      = "2.1.0"
  spec.license      = "MIT"
  spec.summary      = "Swift 开发工具包"
  spec.author       = { "ebamboo" => "1453810050@qq.com" }
  
  spec.homepage     = "https://github.com/ebamboo/Jasmine"
  spec.source       = { :git => "https://github.com/ebamboo/Jasmine.git", :tag => spec.version }

  spec.source_files = "Jasmine/Tools/*.swift"
  
  spec.swift_versions = ["5.3", "5.4", "5.5"]
  spec.platform     = :ios, "11.0"
  
end
