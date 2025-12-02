# Fridge Scanner App - Implementation Complete! 🎉

A Ruby on Rails web application that uses AI to scan fridge images, identify food items, estimate expiration dates, and recommend meals based on available ingredients.

## Features Implemented ✅

### 1. User Authentication
- ✅ User sign up, sign in, and sign out functionality
- ✅ Secure password encryption with Devise
- ✅ User-specific data isolation

### 2. Image Upload & AI Detection
- ✅ Upload images of fridge contents or grocery hauls
- ✅ AI-powered item detection using OpenAI's GPT-4o-mini with vision
- ✅ Automatic expiration date estimation
- ✅ Support for JPG, PNG, and WebP formats

### 3. Fridge Inventory Management
- ✅ View all items in your fridge
- ✅ Manual add, edit, and delete items
- ✅ Track expiration dates
- ✅ Alerts for items expiring within 3 days
- ✅ Quantity tracking

### 4. Meal Suggestions
- ✅ AI-generated recipe suggestions based on available ingredients
- ✅ Meal type filters (Breakfast, Lunch, Dinner, Snack)
- ✅ Highlights which ingredients you have vs. missing
- ✅ Brief cooking instructions for each recipe

### 5. UI/UX
- ✅ Clean, responsive design with PicoCSS
- ✅ Mobile-friendly layout
- ✅ Easy navigation between sections
- ✅ Flash messages for user feedback

## Setup Instructions

### 1. Environment Configuration

**IMPORTANT:** You need to configure your OpenAI API key in the `.env` file:

```bash
# Edit the .env file
nano .env
```

Replace `your_openai_api_key_here` with your actual OpenAI API key:

```
OPENAI_API_KEY=sk-your-actual-api-key-here
```

### 2. Start the Application

```bash
# Start the Rails server
bin/dev
```

The application will be available at `http://localhost:3000`

### 3. Create Your First User

1. Navigate to `http://localhost:3000`
2. Click "Get Started" or "Sign Up"
3. Create an account with email and password
4. You'll be redirected to your fridge inventory

## How to Use

### Scanning Your Fridge

1. **Navigate to "Scan Fridge"** from the top menu
2. **Upload an image** of your fridge or grocery haul
3. **Click "Analyze Image"**
4. The AI will detect items and add them to your inventory automatically

### Managing Items Manually

1. **Click "Add Item Manually"** to add a single item
2. **Edit** any item to correct name, quantity, or expiration date
3. **Delete** items when consumed or expired

### Getting Recipe Suggestions

1. **Navigate to "Recipes"** from the top menu
2. **Select meal type** (Breakfast, Lunch, Dinner, or Snack)
3. View personalized recipes based on your fridge contents
4. See which ingredients you have and which you need to buy

## Technical Architecture

### Models
- **User**: Devise authentication
- **Item**: Fridge inventory items with associations to users

### Controllers
- **HomeController**: Landing page
- **ItemsController**: CRUD operations + AI image analysis
- **RecipesController**: Recipe generation

### Services
- **FridgeAiService**: Analyzes fridge images using OpenAI Vision API
- **RecipeAiService**: Generates recipe suggestions using OpenAI GPT

### Key Technologies
- **Rails 8**: Framework
- **PostgreSQL**: Database
- **Devise**: Authentication
- **Active Storage**: Image uploads
- **ai-chat gem**: OpenAI API integration
- **PicoCSS**: Styling

## Database Schema

### Users Table
- email (string)
- encrypted_password (string)
- timestamps

### Items Table
- user_id (references users)
- name (string)
- quantity (integer)
- expiration_date (date)
- ai_detected (boolean)
- detected_at (datetime)
- timestamps

### Active Storage Tables
- active_storage_blobs
- active_storage_attachments
- active_storage_variant_records

## Routes

```
GET    /                           # Home page
GET    /users/sign_up              # Sign up
GET    /users/sign_in              # Sign in
DELETE /users/sign_out             # Sign out

GET    /items                      # View fridge inventory
GET    /items/new                  # Add item manually
POST   /items                      # Create item
GET    /items/:id/edit             # Edit item
PATCH  /items/:id                  # Update item
DELETE /items/:id                  # Delete item
GET    /items/scan_fridge          # Upload fridge image
POST   /items/analyze_image        # Process uploaded image

GET    /recipes                    # View recipe suggestions
```

## Important Files

- **Models**: `app/models/user.rb`, `app/models/item.rb`
- **Controllers**: `app/controllers/items_controller.rb`, `app/controllers/recipes_controller.rb`
- **Services**: `app/services/fridge_ai_service.rb`, `app/services/recipe_ai_service.rb`
- **Views**: `app/views/items/`, `app/views/recipes/`, `app/views/home/`
- **Routes**: `config/routes.rb`
- **Layout**: `app/views/layouts/application.html.erb`

## Testing the AI Features

### Test Image Analysis
1. Find a photo of your fridge or take one
2. Go to "Scan Fridge"
3. Upload the image
4. Wait for AI to process (takes ~5-10 seconds)
5. Check your fridge inventory for detected items

### Test Recipe Generation
1. Add at least 3-4 items to your fridge (manually or via scan)
2. Go to "Recipes"
3. Select a meal type
4. View AI-generated recipe suggestions

## Troubleshooting

### OpenAI API Key Issues
- Make sure your API key is correctly set in `.env`
- Verify the key has credits available
- Check that dotenv is loading (should load automatically)

### Image Upload Issues
- Ensure images are in JPG, PNG, or WebP format
- Keep file sizes reasonable (< 10MB recommended)
- Make sure Active Storage is properly configured

### Database Issues
```bash
# Reset database if needed
bin/rails db:reset
```

## Next Steps / Future Enhancements

Potential features to add:
- [ ] Shopping list generation based on missing ingredients
- [ ] Barcode scanning for faster item entry
- [ ] Calendar integration for meal planning
- [ ] Sharing recipes with other users
- [ ] Nutritional information tracking
- [ ] Integration with grocery delivery services
- [ ] Multi-image batch processing
- [ ] Export inventory to CSV/PDF

## Notes

- AI detection is not 100% accurate - users can edit any AI-detected items
- Expiration date estimates are approximate based on typical shelf life
- Recipe suggestions prioritize using items you already have
- All features require user authentication

---

**Status**: ✅ MVP Complete and Ready to Use!
**Built with**: Ruby on Rails 8, OpenAI GPT-4o-mini, PostgreSQL, PicoCSS
