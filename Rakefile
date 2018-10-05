task default: :test

task :test do
  if ARGV[1]
    require "./#{ARGV[1]}"
  else
    Dir.glob('./test/**/*_spec.rb') { |f| require(f) }
    Dir.glob('./test/**/test_*.rb') { |f| require(f) }
  end
end
