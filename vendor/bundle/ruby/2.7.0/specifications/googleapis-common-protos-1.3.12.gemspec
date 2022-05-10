# -*- encoding: utf-8 -*-
# stub: googleapis-common-protos 1.3.12 ruby lib

Gem::Specification.new do |s|
  s.name = "googleapis-common-protos".freeze
  s.version = "1.3.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Google LLC".freeze]
  s.date = "2021-09-03"
  s.description = "Common gRPC and protocol buffer classes used in Google APIs".freeze
  s.email = ["googleapis-packages@google.com".freeze]
  s.homepage = "https://github.com/googleapis/common-protos-ruby".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "3.3.13".freeze
  s.summary = "Common gRPC and protocol buffer classes used in Google APIs".freeze

  s.installed_by_version = "3.3.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<googleapis-common-protos-types>.freeze, ["~> 1.2"])
    s.add_runtime_dependency(%q<google-protobuf>.freeze, ["~> 3.14"])
    s.add_runtime_dependency(%q<grpc>.freeze, ["~> 1.27"])
  else
    s.add_dependency(%q<googleapis-common-protos-types>.freeze, ["~> 1.2"])
    s.add_dependency(%q<google-protobuf>.freeze, ["~> 3.14"])
    s.add_dependency(%q<grpc>.freeze, ["~> 1.27"])
  end
end
