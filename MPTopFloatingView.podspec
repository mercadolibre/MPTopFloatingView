Pod::Spec.new do |s|
  s.name             = "MPTopFloatingView"
  s.version          = "0.2.3"
  s.summary          = "Mercado Pago Top Floating View"

  s.description      = <<-DESC
                       Use this Pod to add a top floating view
                       DESC

  s.homepage         = "https://github.com/mercadolibre/MPTopFloatingView"
  s.license          = 'Apache License, Version 2.0'
  s.author           = { "MPMobile" => "mpmobileios@mercadolibre.com" }

  s.source           = { :git => "https://github.com/mercadolibre/MPTopFloatingView.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resources = ['Pod/Resources/**/*.{xib}','Pod/Assets/**/*.{xcassets}']

end
