source 'https://rubygems.org'

# Specify your gem's dependencies in novel_compression.gemspec
gemspec

group :development, :test do
	gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
	gem 'reek', '~> 1.3.7'
	gem 'rubocop', '~> 0.23'
end
