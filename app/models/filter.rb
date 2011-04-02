class Filter < ActiveRecord::Base
  acts_as_api
  
  api_accessible :base do |template|
      template.add   :name
      template.add  :version
      template.add  :layers
      template.add  :package
  end
  
  def layers
    return [[
              :Opacity => self.layer1_opacity,
              :BlendMode => self.layer1_blend_mode,
              :LandscapePreviewImage => self.layer1_landscape_preview_image,
              :LandscapeImage => self.layer1_landscape_image,
              :PortraitPreviewImage => self.layer1_portrait_preview_image,
              :PortraitImage => self.layer1_portrait_image ],
            [
              :Opacity => self.layer2_opacity,
              :BlendMode => self.layer2_blend_mode,
              :LandscapePreviewImage => self.layer2_landscape_preview_image,
              :LandscapeImage => self.layer2_landscape_image,
              :PortraitPreviewImage => self.layer2_portrait_preview_image,
              :PortraitImage => self.layer2_portrait_image ],
            [
              :Opacity => self.layer3_opacity,
              :BlendMode => self.layer3_blend_mode,
              :LandscapePreviewImage => self.layer3_landscape_preview_image,
              :LandscapeImage => self.layer3_landscape_image,
              :PortraitPreviewImage => self.layer3_portrait_preview_image,
              :PortraitImage => self.layer3_portrait_image ]
           ]
  end
  
end
