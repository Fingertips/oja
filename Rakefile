
task :default => :specs

desc "Run all specs"
task :specs do
  FileList['spec/*_spec.rb'].sort.each do |spec|
    sh "ruby -I lib #{spec} -e ''"
  end
end