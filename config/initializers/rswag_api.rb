Rswag::Api.configure do |c|
  # Root folder where OpenAPI/Swagger JSON files are located
  # (Renamed from swagger_root in rswag >= 3.0)
  if c.respond_to?(:openapi_root=)
    c.openapi_root = Rails.root.join('config', 'swagger').to_s
  else
    # fallback for older rswag versions just in case
    c.swagger_root = Rails.root.join('config', 'swagger').to_s
  end

  # Hook to modify the returned spec before serialization (optional)
  # c.swagger_filter = lambda { |swagger, env| swagger['host'] = env['HTTP_HOST'] }
end
