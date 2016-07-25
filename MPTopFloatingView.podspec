Pod::Spec.new do |s|
  s.name             = "MPTopFloatingView"
  s.version          = "0.1.0"
  s.summary          = "Mercado Pago Top Floating View"

  s.description      = <<-DESC
                       Use this Pod to add a top floating view
                       DESC

  s.homepage         = "https://github.com/mercadolibre/mpmobile-ios_topfloatingview"
  s.license          = 'none'
  s.author           = { "MPMobile" => "mpmobile@mercadolibre.com" }

  s.source           = { :git => "git@github.com:mercadolibre/mpmobile-ios_topfloatingview.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resources = ['Pod/Resources/**/*.{xib}','Pod/Assets/**/*.{xcassets}']

end