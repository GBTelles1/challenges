class BahamasClientsController < ApplicationController
  # POST /store-bahamas-client/:invoice_id?fiscal_id=999999999&name=Bob&email=bob@bob.com
  def store
    # Find or create the invoice by id
    invoice = Invoice.find_or_create_by(id: params[:invoice_id])

    # Fetch parameters and raise ParameterMissing error if they are missing
    fiscal_id = params.fetch(:fiscal_id)
    name = params.fetch(:name)
    email = params.fetch(:email)

    # Check if a client with the same fiscal_id already exists
    client = Client.find_by(fiscal_id: fiscal_id)

    if client
      # If client exists, associate with the invoice
      invoice.clients << client unless invoice.clients.include?(client)
      render json: { message: "Client #{client.name} has been associated with the invoice #{invoice.id}." }, status: :ok
    else
      # Create a new client and associate with the invoice
      client = invoice.clients.create(
        fiscal_id: fiscal_id,
        name: name,
        email: email
      )

      if client.persisted?
        # Mocking the external service call to Bahamas
        bahamas_service_response = MockBahamasGov.mock_service(client, invoice.id)

        render json: { client: client, bahamas_service_response: bahamas_service_response }, status: :created
      else
        render json: client.errors, status: :unprocessable_entity
      end
    end
  end

  # GET /retrieve-bahamas-client/:invoice_id
  def retrieve
    invoice = Invoice.find_by(id: params[:invoice_id])
    if invoice && invoice.clients.any?
      render json: invoice.clients, status: :ok
    else
      render json: { error: 'No client found for this invoice' }, status: :not_found
    end
  end
end
