desc "Build frontend"
task :build do
  sh "npm install"

  Dir.chdir('frontend') do
    sh "npm install"
    sh "npm run build"
  end
end

task "assets:precompile" => ["build"]
