task "db:drop_connection" => ["environment"] do
  ApplicationRecord.connection.execute <<~SQL
    SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pid <> pg_backend_pid();
  SQL
end

task "db:drop:_unsafe" => ["db:drop_connection"]
