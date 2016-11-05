
Pod::Spec.new do |s|

  s.name         = "SpriteKitElements"
  s.version      = "0.4.1"
  s.summary      = "A small swift framework for attaching additional functionality to any SKNode"
  s.homepage     = "https://github.com/nacrossweb/SpriteKitElements"
  s.license      = 'MIT'
  s.author       = { "Nicholas Cross" => "isthisreallyneeded78908657634257756@gmail.com" }
  s.platform     = :ios, '9.0'
  s.source       = { :git => "https://github.com/nacrossweb/SpriteKitElements.git", :tag => "0.4.1" }
  s.source_files  = 'SpriteKitElements/SpriteKitElements/*'
  s.framework  = 'SpriteKit'
  s.requires_arc = true
  s.dependency 'WeakDictionary', '~> 1.2.1'
end