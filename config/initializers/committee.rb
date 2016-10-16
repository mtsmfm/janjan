Rails.application.config.middleware.use Committee::Middleware::ResponseValidation, schema: JSON.parse(File.read('schema.json')), raise: true
