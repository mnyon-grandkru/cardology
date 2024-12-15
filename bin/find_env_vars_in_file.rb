require 'find'

def find_env_vars_in_file(file_path)
	env_vars = []
	File.readlines(file_path).each do |line|
		env_vars.concat(line.scan(/ENV\[['"](\w+)['"]\]/))
	end
	env_vars.flatten.uniq
end

def find_all_env_vars_in_rails_project(project_path)
	all_env_vars = []
	Find.find(project_path) do |path|
		if FileTest.directory?(path)
			if File.basename(path) == 'tmp' || File.basename(path) == 'log'
				Find.prune
			else
				next
			end
		elsif path.end_with?('.rb')
			all_env_vars.concat(find_env_vars_in_file(path))
		end
	end
	all_env_vars.uniq.sort
end

# Usage
rails_project_path = Dir.pwd
env_vars = find_all_env_vars_in_rails_project(rails_project_path)
puts "Environment variables used in the project:"
puts env_vars
