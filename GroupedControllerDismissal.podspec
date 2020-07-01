Pod::Spec.new do |s|

  s.name                    = "GroupedControllerDismissal"
  s.module_name             = "GroupedControllerDismissal"
  s.version                 = "1.0.0"
  s.summary                 = "Helper code to dismiss stack of modal controllers (in fullscreen mode) as single group"

  s.homepage                = "https://github.com/ladeiko/GroupedControllerDismissal"
  s.license                 = 'MIT'
  s.authors                 = { "Siarhei Ladzeika" => "sergey.ladeiko@gmail.com" }
  
  s.source                  = { :git => "https://github.com/ladeiko/GroupedControllerDismissal.git", :tag => s.version.to_s }
  
  s.ios.deployment_target   = '10.0'
  s.swift_versions          = ['4.2', '5.0', '5.1', '5.2']
  s.requires_arc            = true

  s.source_files            = "Source/*.{swift}"

end
