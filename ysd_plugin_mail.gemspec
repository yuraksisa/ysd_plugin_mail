Gem::Specification.new do |s|
  s.name    = "ysd_plugin_mail"
  s.version = "0.1"
  s.authors = ["Yurak Sisa Dream"]
  s.date    = "2011-10-27"
  s.email   = ["yurak.sisa.dream@gmail.com"]
  s.files   = Dir['lib/**/*.rb','views/**/*.erb','i18n/**/*.yml','static/**/*.*'] 
  s.description = "Mail integration"
  s.summary = "Mail integration"
  
  s.add_runtime_dependency "json"
  
  s.add_runtime_dependency "ysd_md_mail"      # Mail Model
  s.add_runtime_dependency "ysd_plugin_cms"  # Site builder
  s.add_runtime_dependency "ysd_core_themes"  # Theming  
  s.add_runtime_dependency "ysd_core_plugins" # Plugins

end