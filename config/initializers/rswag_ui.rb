Rswag::Ui.configure do |c|
  # Endpoint exposing the OpenAPI/Swagger document. Rswag will rename this to openapi_endpoint in v3.
  if c.respond_to?(:openapi_endpoint)
    c.openapi_endpoint '/api-docs/v1/swagger.yaml', 'Olio API V1'
  else
    c.swagger_endpoint '/api-docs/v1/swagger.yaml', 'Olio API V1'
  end
end
