# -*- encoding: utf-8 -*-
# stub: rly 0.2.3 ruby lib

Gem::Specification.new do |s|
  s.name = "rly".freeze
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Vladimir Pouzanov".freeze]
  s.date = "2013-01-03"
  s.description = "A simple ruby implementation of lex and yacc, based on Python's ply".freeze
  s.email = ["farcaller@gmail.com".freeze]
  s.homepage = "".freeze
  s.rubygems_version = "3.3.13".freeze
  s.summary = "A simple ruby implementation of lex and yacc, based on Python's ply".freeze

  s.installed_by_version = "3.3.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
  else
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
