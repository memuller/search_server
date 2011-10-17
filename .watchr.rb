interrupted = false
Signal.trap('INT') {
	if interrupted
		exit 0
	else
		interrupted = true
		puts 'Running entire test suit (Ctrl+C again to quit)...'
		Kernel.sleep 1
		interrupted = false
		run_spec
	end
}

def run_spec(file='spec')
  unless File.exist?(file)
    puts "#{file} does not exist"
    return
  end

  puts "Running #{file}"
  cmd = system "bundle exec rspec #{file}"
  puts
end

watch("spec/.*/*_spec.rb") do |match|
  run_spec match[0]
end

watch("app/(.*/.*).rb") do |match|
  run_spec %{spec/#{match[1]}_spec.rb}
end