require 'minitest/autorun'

Dir.glob('Specs/**/*_spec.rb') { |f| require_relative(f) }