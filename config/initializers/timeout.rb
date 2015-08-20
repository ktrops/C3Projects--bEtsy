Rails.application.config.middleware.insert_before Rack::Runtime, Rack::Timeout

Rack::Timeout.timeout = 30
