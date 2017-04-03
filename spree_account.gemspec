# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_account'
  s.version     = '3.1.0'
  s.summary     = 'Show user account'
  s.description = ''
  s.required_ruby_version = '>= 2.1.0'

  s.author    = 'Stanislav Valkanov'
  s.email     = 'svalkanov97@gmail.com'
  s.license = 'BSD-3'

  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 3.1.0'
end
