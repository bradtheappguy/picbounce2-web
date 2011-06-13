class Filter < ActiveRecord::Base
  acts_as_api
  
  api_accessible :base do |template|
      template.add  :Name
      template.add  :Version
      template.add  :Layers
      template.add  :Package
      template.add  :InstalledAsDefault
  end
  
  def InstalledAsDefault
      return 'YES'
  end
   def Name
      return self.name
  end
   def Version
      return self.version
   end
   def Package
      return self.package
  end
  
  def Layers
    layers = [{
              :Opacity => self.layer1_opacity,
              :BlendMode => self.layer1_blend_mode,
              :LandscapePreviewImage => self.layer1_landscape_preview_image,
              :LandscapeImage => self.layer1_landscape_image,
              :PortraitPreviewImage => self.layer1_portrait_preview_image,
              :PortraitImage => self.layer1_portrait_image }]
            
             if self.layer2_blend_mode != nil
                 layers[1] = {:Opacity => self.layer2_opacity,
                :BlendMode => self.layer2_blend_mode,
                :LandscapePreviewImage => self.layer2_landscape_preview_image,
                :LandscapeImage => self.layer2_landscape_image,
                :PortraitPreviewImage => self.layer2_portrait_preview_image,
                :PortraitImage => self.layer2_portrait_image }
              end
              if self.layer3_blend_mode != nil
                layers[2] = {:Opacity => self.layer3_opacity,
                  :BlendMode => self.layer3_blend_mode,
                  :LandscapePreviewImage => self.layer3_landscape_preview_image,
                  :LandscapeImage => self.layer3_landscape_image,
                  :PortraitPreviewImage => self.layer3_portrait_preview_image,
                  :PortraitImage => self.layer3_portrait_image }
              end
           
      return layers    
              
  end
  
end
