# -*- encoding: utf-8 -*-
# stub: kaminari 0.17.0 ruby lib

Gem::Specification.new do |s|
  s.name = "kaminari".freeze
  s.version = "0.17.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Akira Matsuda".freeze, "Yuki Nishijima".freeze, "Zachary Scott".freeze, "Hiroshi Shibata".freeze]
  s.date = "2016-05-31"
  s.description = "Kaminari is a Scope & Engine based, clean, powerful, agnostic, customizable and sophisticated paginator for Rails 3+".freeze
  s.email = ["ronnie@dio.jp".freeze]
  s.extra_rdoc_files = ["README.rdoc".freeze]
  s.files = ["README.rdoc".freeze]
  s.homepage = "https://github.com/amatsuda/kaminari".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.3.13".freeze
  s.summary = "A pagination engine plugin for Rails 3+ and other modern frameworks".freeze

  s.installed_by_version = "3.3.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activesupport>.freeze, [">= 3.0.0"])
    s.add_runtime_dependency(%q<actionpack>.freeze, [">= 3.0.0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 1.0.0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<tzinfo>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<rr>.freeze, [">= 0"])
    s.add_development_dependency(%q<capybara>.freeze, [">= 1.0"])
    s.add_development_dependency(%q<database_cleaner>.freeze, ["~> 1.2.0"])
    s.add_development_dependency(%q<rdoc>.freeze, [">= 0"])
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 3.0.0"])
    s.add_dependency(%q<actionpack>.freeze, [">= 3.0.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.0.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<tzinfo>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rr>.freeze, [">= 0"])
    s.add_dependency(%q<capybara>.freeze, [">= 1.0"])
    s.add_dependency(%q<database_cleaner>.freeze, ["~> 1.2.0"])
    s.add_dependency(%q<rdoc>.freeze, [">= 0"])
  end
end
