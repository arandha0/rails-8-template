class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:edit, :update, :destroy]

  def index
    @items = current_user.items.order(expiration_date: :asc)
    @expiring_soon = @items.expiring_soon
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)

    if @item.save
      redirect_to items_path, notice: "Item was successfully added to your fridge."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to items_path, notice: "Item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: "Item was successfully removed from your fridge."
  end

  def scan_fridge
    # Page for uploading fridge image
  end

  def analyze_image
    unless params[:image].present?
      redirect_to scan_fridge_items_path, alert: "Please upload an image."
      return
    end

    begin
      # Save temporary image
      uploaded_image = params[:image]

      # Use AI service to analyze the image
      ai_service = FridgeAiService.new
      items_data = ai_service.analyze_fridge_image(uploaded_image)

      # Create items from AI results
      created_count = 0
      items_data.each do |item_data|
        item = current_user.items.create(
          name: item_data[:name],
          quantity: item_data[:quantity] || 1,
          expiration_date: item_data[:expiration_date],
          ai_detected: true,
          detected_at: Time.current
        )
        created_count += 1 if item.persisted?
      end

      redirect_to items_path, notice: "Successfully detected #{created_count} items from your fridge image!"
    rescue => e
      redirect_to scan_fridge_items_path, alert: "Error analyzing image: #{e.message}"
    end
  end

  private

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :quantity, :expiration_date, :image)
  end
end
