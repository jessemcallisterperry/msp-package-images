## 🎞️ Development Plan: Sketch-to-Placeholder Feature (v0)

### ✫️ Goal

Allow users to upload a sketch and return a fixed placeholder thumbnail (from a URL). All sketches are stored with ActiveStorage in the database.

All business logic related to image generation and processing must be handled using a service object to keep the controller lean and the architecture maintainable.

---

## 📋 Step-by-Step Tasks

### 1. **Set up ActiveStorage**

```bash
bin/rails active_storage:install
bin/rails db:migrate
```

---

### 2. **Generate model, controller, and views**

```bash
bin/rails g scaffold GeneratedThumbnail
```

Update the model to support ActiveStorage:

```ruby
# app/models/generated_thumbnail.rb
class GeneratedThumbnail < ApplicationRecord
  has_one_attached :sketch
end
```

---

### 3. **Update routes**

Ensure the routes only expose the necessary actions:

```ruby
# config/routes.rb
resources :generated_thumbnails, only: [:new, :create, :show]
root "generated_thumbnails#new"
```

---

### 4. **Create service for image generation**

Create a service class to handle image generation logic:

```ruby
# app/services/thumbnail_generator_service.rb
class ThumbnailGeneratorService
  PLACEHOLDER_URL = "https://placehold.co/1280x720"

  def initialize(generated_thumbnail)
    @generated_thumbnail = generated_thumbnail
  end

  def generate
    # Currently returns placeholder URL, future-proofed for AI API integration
    PLACEHOLDER_URL
  end
end
```

---

### 5. **Handle image upload and call the service**

In `GeneratedThumbnailsController#create`:

```ruby
def create
  @generated_thumbnail = GeneratedThumbnail.new

  if params[:generated_thumbnail][:sketch]
    @generated_thumbnail.sketch.attach(params[:generated_thumbnail][:sketch])
  end

  if @generated_thumbnail.save
    @thumbnail_url = ThumbnailGeneratorService.new(@generated_thumbnail).generate
    redirect_to @generated_thumbnail
  else
    render :new
  end
end
```

In `GeneratedThumbnailsController#show`, assign the placeholder URL:

```ruby
def show
  @generated_thumbnail = GeneratedThumbnail.find(params[:id])
  @thumbnail_url = ThumbnailGeneratorService.new(@generated_thumbnail).generate
end
```

---

### 6. **Create and update views**

**New view (upload form)** - `app/views/generated_thumbnails/new.html.erb`

```erb
<h1>Upload Your Sketch</h1>

<%= form_with model: @generated_thumbnail, local: true do |form| %>
  <div>
    <%= form.label :sketch %><br>
    <%= form.file_field :sketch %>
  </div>
  <br>
  <%= form.submit "Generate Thumbnail" %>
<% end %>
```

**Show view (results)** - `app/views/generated_thumbnails/show.html.erb`

```erb
<h1>Result</h1>

<h2>Original Sketch</h2>
<% if @generated_thumbnail.sketch.attached? %>
  <%= image_tag @generated_thumbnail.sketch %>
<% else %>
  <p>No sketch uploaded.</p>
<% end %>

<h2>Generated Thumbnail (Placeholder)</h2>
<%= image_tag @thumbnail_url, alt: "Placeholder Thumbnail" %>

<br>
<%= link_to "Upload Another", new_generated_thumbnail_path %>
```

---

### 7. **Add file validations**

Update `app/models/generated_thumbnail.rb`:

```ruby
validate :sketch_size_and_format

def sketch_size_and_format
  return unless sketch.attached?

  if sketch.byte_size > 25.megabytes
    errors.add(:sketch, "must be under 25MB")
  end

  acceptable_types = ["image/jpeg", "image/png"]
  unless acceptable_types.include?(sketch.content_type)
    errors.add(:sketch, "must be a JPG or PNG")
  end
end
```

---

## ✅ Done When:

*
