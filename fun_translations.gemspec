# frozen_string_literal: true

require File.expand_path('lib/fun_translations/version', __dir__)

Gem::Specification.new do |spec|
  spec.name                  = 'fun_translations'
  spec.version               = FunTranslations::VERSION
  spec.authors               = ['Ilya Krukowski']
  spec.email                 = ['golosizpru@gmail.com']
  spec.summary               = 'Ruby interface for FunTranslations API.'
  spec.description           = 'This is a Ruby client that enables you to easily perform translations using ' \
                               'FunTranslations API.'
  spec.homepage              = 'https://github.com/bodrovis/fun_translations'
  spec.license               = 'MIT'
  spec.platform              = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.7.0'

  spec.files = Dir['README.md', 'LICENSE.md',
                   'CHANGELOG.md', 'lib/**/*.rb',
                   'fun_translations.gemspec', '.github/*.md',
                   'Gemfile', 'Rakefile']
  spec.extra_rdoc_files = ['README.md']
  spec.require_paths    = ['lib']

  spec.add_dependency 'faraday', '~> 2.6'
  spec.add_dependency 'zeitwerk', '~> 2.4'
  spec.add_development_dependency 'codecov', '~> 0.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'rubocop', '~> 1.6'
  spec.add_development_dependency 'rubocop-performance', '~> 1.5'
  spec.add_development_dependency 'rubocop-rspec',       '~> 2.0'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'webmock', '~> 3.14'

  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }
end
