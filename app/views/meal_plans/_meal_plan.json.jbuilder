json.extract! meal_plan, :id, :name, :active, :created_at, :updated_at
json.url meal_plan_url(meal_plan, format: :json)