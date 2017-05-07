Pod::Spec.new do |s|

  s.name         = "GLXMacDrawerController"
  s.version      = "0.1.0"
  s.summary      = "Custom drawer controller for macOS 10.11 and above."

  s.description  = <<-DESC
                   Written in Swift.
                   Supports both layer backed and non-layer backed views.
                   Supports instantiation via storyboards.
                   Still a work in progress so new features are coming very soon. Contributions are welcome.
                   DESC

  s.homepage     = "https://github.com/glenmax-ltd/GLXMacDrawerController"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.authors       = { "Glenmax" => "support@glenmax.com" }
  s.platform     = :macos, "10.10"

  s.macos.deployment_target = "10.10"

  s.source       = {
                    :git => "https://github.com/glenmax-ltd/GLXMacDrawerController.git",
                    :branch => "master",
                    :tag => "v0.1.0"}


  s.source_files  = "GLXMacDrawerController/*.swift"
  s.requires_arc = true
  s.frameworks = 'Cocoa'
  
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }

end
