class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :update, :destroy, :add_client, :remove_client]

  # GET /invoices
  def index
    @invoices = Invoice.all
    render json: @invoices.as_json(include: :clients)
  end

  # GET /invoices/:id
  def show
    render json: @invoice.as_json(include: :clients)
  end

  # POST /invoices
  def create
    # Check if an invoice with the same id already exists
    @invoice = Invoice.find_by(id: invoice_params[:id])

    if @invoice
      render json: { message: 'Invoice already exists', invoice: @invoice }, status: :ok
    else
      @invoice = Invoice.new(invoice_params)

      if @invoice.save
        render json: @invoice, status: :created, location: @invoice
      else
        render json: @invoice.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /invoices/:id
  def update
    if @invoice.update(invoice_params)
      render json: @invoice.as_json(include: :clients)
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /invoices/:id
  def destroy
    @invoice.destroy
    head :no_content
  end

  # POST /invoices/:id/add_client
  def add_client
    client = Client.find_by(fiscal_id: client_params[:fiscal_id])

    if client
      if @invoice.clients.include?(client)
        render json: { message: 'Client is already associated with this invoice.' }, status: :ok
      else
        @invoice.clients << client
        render json: {
          message: 'Client successfully added to invoice.',
          invoice: @invoice.as_json(include: :clients)
        }, status: :ok
      end
    else
      render json: { error: 'Client not found' }, status: :not_found
    end
  end

  # DELETE /invoices/:id/remove_client
  def remove_client
    client = Client.find_by(fiscal_id: client_params[:fiscal_id])

    if client && @invoice.clients.include?(client)
      @invoice.clients.delete(client)
      render json: {
        message: 'Client successfully removed from invoice.',
        invoice: @invoice.as_json(include: :clients)
      }, status: :ok

    else
      render json: { error: 'Client not associated with this invoice or not found' }, status: :not_found
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Invoice not found' }, status: :not_found
  end

  # Ensure invoice params exist on the request.
  def invoice_params
    params.require(:invoice).permit(:id)
  end

  def client_params
    params.require(:client).permit(:fiscal_id)
  end
end
