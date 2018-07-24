json.extract! item, :id, :title, :description, :lecturer, :price, :image_url, :category, :skill_level, :created_at, :updated_at
json.url item_url(item, format: :json)
