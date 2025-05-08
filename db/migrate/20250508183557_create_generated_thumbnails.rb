class CreateGeneratedThumbnails < ActiveRecord::Migration[8.0]
  def change
    create_table :generated_thumbnails do |t|
      t.timestamps
    end
  end
end
