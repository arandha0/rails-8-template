class FridgeAiService
  def analyze_fridge_image(uploaded_file)
    # Prepare the prompt for OpenAI
    prompt = <<~PROMPT
      Analyze this image of a fridge or grocery haul and identify all visible food items.

      For each item, provide:
      1. Item name (be specific, e.g., "Whole Milk" not just "Milk")
      2. Approximate quantity (number of items visible)
      3. Estimated days until expiration (be realistic based on typical shelf life)

      Return the results as a JSON array with this exact format:
      [
        {
          "name": "Item name",
          "quantity": 1,
          "days_until_expiration": 7
        }
      ]

      Only return the JSON array, no other text.
    PROMPT

    # Create AI::Chat instance
    chat = AI::Chat.new

    # Add the prompt with the image using the user method
    chat.user(prompt, image: uploaded_file)

    # Generate response
    response = chat.generate!

    # Parse the response
    content = response[:content]

    # Extract JSON from the response (in case there's extra text)
    json_match = content.match(/\[.*\]/m)
    items_json = json_match ? json_match[0] : content

    items_data = JSON.parse(items_json)

    # Transform to our expected format
    items_data.map do |item|
      {
        name: item["name"],
        quantity: item["quantity"] || 1,
        expiration_date: item["days_until_expiration"].to_i.days.from_now.to_date
      }
    end
  rescue JSON::ParserError => e
    Rails.logger.error("Failed to parse AI response: #{e.message}")
    Rails.logger.error("Response content: #{content}")
    raise "Failed to parse AI response. Please try again."
  rescue => e
    Rails.logger.error("AI Service Error: #{e.message}")
    raise "Failed to analyze image: #{e.message}"
  end
end
