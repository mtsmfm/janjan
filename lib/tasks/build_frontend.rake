desc "Build frontend"
task :build do
  sh "bin/rails webpack:compile"
end

task "assets:precompile" => ["build"]

task "cleanup_structure" do
  filename = ENV["SCHEMA"] || File.join(ActiveRecord::Tasks::DatabaseTasks.db_dir, "structure.sql")
  structure = File.read(filename).gsub(%r|COMMENT ON EXTENSION "?(.+?)"? IS '.*';|) do |matched|
    <<~SQL
      DO $$
      BEGIN
      IF NOT EXISTS (SELECT name FROM pg_available_extensions WHERE name='#{$1}' AND installed_version IS NOT NULL) THEN
      #{matched}
      END IF;
      END $$;
    SQL
  end
  File.write(filename, structure)
end

Rake::Task["db:structure:dump"].enhance do
  Rake::Task["cleanup_structure"].invoke
end
