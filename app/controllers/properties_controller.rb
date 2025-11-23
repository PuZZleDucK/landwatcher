class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show update destroy ]

  # GET /properties
  def index
    page = params[:page].to_i || 1
    per_page = params[:per_page].to_i || 10
    offset = (page - 1) * per_page
    @properties = Property.offset(offset).limit(per_page)

    render json: @properties
  end

  # GET /properties/1
  def show
    render json: @property
  end

  # POST /properties
  def create
    @property = Property.new(property_params)

    if @property.save
      render json: @property, status: :created, location: @property
    else
      render json: @property.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /properties/1
  def update
    if @property.update(property_params)
      render json: @property
    else
      render json: @property.errors, status: :unprocessable_content
    end
  end

  # DELETE /properties/1
  def destroy
    @property.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def property_params
      params.expect(property: [ :title, :description, :price, :bedrooms, :type ])
    end
end
