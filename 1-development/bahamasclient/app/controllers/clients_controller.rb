class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :update, :destroy]

  # GET /clients
  def index
    @clients = Client.all
    render json: @clients.as_json(include: :invoices)
  end

  # GET /clients/:id
  def show
    render json: @client.as_json(include: :invoices)
  end

  # POST /clients
  def create
    @client = Client.new(client_params)
    if @client.save
      render json: @client.as_json(include: :invoices), status: :created, location: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clients/:id
  def update
    if @client.update(client_params)
      render json: @client.as_json(include: :invoices)
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clients/:id
  def destroy
    @client.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Client not found' }, status: :not_found
  end

  # Ensure client params exist on the request.
  def client_params
    params.require(:client).permit(:fiscal_id, :name, :email)
  end
end
