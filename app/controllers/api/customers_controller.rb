class Api::CustomersController < ApplicationController
  before_action :set_customer, only: %i[ destroy ]

  def index
    fetch_customers

    render json: @customers
  end

  def create
    CreateCustomerService.new(customer_params).call

    fetch_customers

    render json: @customers, status: :created, location: api_customer_path(@customers)
  end

  def destroy
    @customer.destroy
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.permit(_json: [:cep, :name]).require(:_json)
  end

  def fetch_customers
    @customers = Customer.includes(:addresses).to_json(include: :addresses)
  end
end
