Rails.application.config.middleware.insert_before 0, Rack::Cors do
    unless Rails.env.production?
      allow do
        origins(['localhost', /localhost:\d+\Z/])
  
        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end
end
