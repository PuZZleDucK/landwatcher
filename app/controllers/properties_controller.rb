class PropertiesController < ApplicationController
  before_action :set_property, only: %i[ show update destroy ]

  # GET /properties
  def index
    page = params[:page].to_i || 1
    per_page = params[:per_page].to_i || 10
    offset = (page - 1) * per_page
    price_floor = params[:price_floor].present? ? params[:price_floor].to_i : 0
    price_ceiling = params[:price_ceiling].present? ? params[:price_ceiling].to_i : Float::INFINITY
    query_params = { price: price_floor..price_ceiling }

    @properties = Property.offset(offset).where(query_params).limit(per_page)
    # note: translate the property type from react string using enum + handle 'any' on this side

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
