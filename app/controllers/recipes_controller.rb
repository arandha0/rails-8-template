class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @meal_type = params[:meal_type] || "dinner"
    @items = current_user.items

    if @items.any?
      begin
        ai_service = RecipeAiService.new
        @recipes = ai_service.generate_recipes(@items, @meal_type)
      rescue => e
        @error_message = "Error generating recipes: #{e.message}"
        @recipes = []
      end
    else
      @recipes = []
    end
  end
end
