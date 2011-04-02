class CreateFilters < ActiveRecord::Migration
  def self.up
    create_table :filters do |t|
      t.string  :name
      t.string  :version
      t.float   :layer1_opacity
      t.string  :layer1_blend_mode
      t.string  :layer1_landscape_preview_image
      t.string  :layer1_portrait_preview_image
      t.string  :layer1_landscape_image
      t.string  :layer1_portrait_image
      t.float   :layer2_opacity
      t.string  :layer2_blend_mode
      t.string  :layer2_landscape_preview_image
      t.string  :layer2_portrait_preview_image
      t.string  :layer2_landscape_image
      t.string  :layer2_portrait_image
      t.float   :layer3_opacity
      t.string  :layer3_blend_mode
      t.string  :layer3_landscape_preview_image
      t.string  :layer3_portrait_preview_image
      t.string  :layer3_landscape_image
      t.string  :layer3_portrait_image
      t.string  :package
      t.float   :release
      t.timestamps
   end
  end

  def self.down
    drop_table :filters
  end
end
