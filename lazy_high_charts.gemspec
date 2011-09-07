# -*- encoding: utf-8 -*-
#require File.expand_path("../lib/lazy_high_charts/version", __FILE__)
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'lazy_high_charts/version'

Gem::Specification.new do |s|
  s.name        = "fullscreen_lazy_high_charts"
  s.version     = LazyHighCharts::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Miguel Michelson Martinez','Deshi Xiao', 'Drew Baumann']
  s.email       = ['miguelmichelson@gmail.com','xiaods@gmail.com']
  s.homepage    = "https://github.com/xiaods/lazy_high_charts"
  s.summary     = "lazy higcharts gem for rails -- Modified for Fullscreen, Inc. use."
  s.description = "use highcharts js libary to visualization your data by rubygem/rails"

  s.extra_rdoc_files  = [ "README.md", "CHANGELOG.md" ]
  s.rdoc_options      = [ "--charset=UTF-8" ]

  s.required_rubygems_version = "~> 1.3"

  s.add_dependency "bundler", "~> 1.0"

  s.add_development_dependency "webrat","~> 0.7"
  s.add_development_dependency "rspec", "~> 2.0"
  s.add_development_dependency "rails", "~> 3.0"

  s.description = <<-DESC
    lazy_high_charts is a Rails 3.x gem for displaying Highcharts graphs.  -- Modified for Fullscreen, Inc. use.
    Lets you have multiple charts on a page and update them dynamically.
  DESC

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files`.split("\n").select{|f| f =~ /^bin/}
  s.require_path = 'lib'  

end
