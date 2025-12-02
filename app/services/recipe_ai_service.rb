class RecipeAiService
  def generate_recipes(items, meal_type = "dinner")
    available_items = items.map(&:name).join(", ")

    prompt = <<~PROMPT
      I have the following ingredients in my fridge: #{available_items}

      Please suggest 3-5 #{meal_type} recipes I can make.

      For each recipe, provide:
      1. Recipe name
      2. List of ingredients from my fridge that I have
      3. List of ingredients that are missing (that I would need to buy)
      4. Brief cooking instructions (2-3 sentences)

      Return the results as a JSON array with this exact format:
      [
        {
          "name": "Recipe Name",
          "ingredients_i_have": ["ingredient1", "ingredient2"],
          "missing_ingredients": ["ingredient3", "ingredient4"],
          "instructions": "Brief cooking instructions here."
        }
      ]

      Only return the JSON array, no other text.
      Prioritize recipes where I have most of the ingredients.
    PROMPT

    # Create AI::Chat instance
    chat = AI::Chat.new

    # Add the prompt using the user method
    chat.user(prompt)

    # Generate response
    response = chat.generate!

    content = response[:content]

    # Extract JSON from the response
    json_match = content.match(/\[.*\]/m)
    recipes_json = json_match ? json_match[0] : content

    JSON.parse(recipes_json)
  rescue JSON::ParserError => e
    Rails.logger.error("Failed to parse recipe AI response: #{e.message}")
    Rails.logger.error("Response content: #{content}")
    raise "Failed to parse recipe suggestions. Please try again."
  rescue => e
    Rails.logger.error("Recipe AI Service Error: #{e.message}")
    raise "Failed to generate recipes: #{e.message}"
  end
end
