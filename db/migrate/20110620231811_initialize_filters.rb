ActiveRecord::Base.logger = Logger.new(STDOUT)
class InitializeFilters < ActiveRecord::Migration
  def self.up
    execute <<ENDOFSQL
INSERT INTO filters(
            id, name, version, layer1_opacity, layer1_blend_mode, layer1_landscape_preview_image, 
            layer1_portrait_preview_image, layer1_landscape_image, layer1_portrait_image, 
            layer2_opacity, layer2_blend_mode, layer2_landscape_preview_image, 
            layer2_portrait_preview_image, layer2_landscape_image, layer2_portrait_image, 
            layer3_opacity, layer3_blend_mode, layer3_landscape_preview_image, 
            layer3_portrait_preview_image, layer3_landscape_image, layer3_portrait_image, 
            package, release, created_at, updated_at, filter_type)
    VALUES ('3','Stockholm','1',1,'Normal','Filters-101208_FH_Stark_Normal_100_276x207.png','Filters-101208_FH_Stark_Normal_100_200x266.png','Filters-101208_FH_Stark_Normal_100_600x450.png','Filters-101208_FH_Stark_Normal_100_450x600.png',0.8,'Overlay','Filters-101208_FH_Stark_Blue_Overlay_80_276x207.png','Filters-101208_FH_Stark_Blue_Overlay_80_200x266.png','Filters-101208_FH_Stark_Blue_Overlay_80_600x450.png','Filters-101208_FH_Stark_Blue_Overlay_80_450x600.png',0.8,'Darken','Filters-101208_FH_Stark_Color_Darken_80_276x207.png','Filters-101208_FH_Stark_Color_Darken_80_200x266.png','Filters-101208_FH_Stark_Color_Darken_80_600x450.png','Filters-101208_FH_Stark_Color_Darken_80_450x600.png','',1.6,NULL,NULL,'');
INSERT INTO filters(
            id, name, version, layer1_opacity, layer1_blend_mode, layer1_landscape_preview_image, 
            layer1_portrait_preview_image, layer1_landscape_image, layer1_portrait_image, 
            layer2_opacity, layer2_blend_mode, layer2_landscape_preview_image, 
            layer2_portrait_preview_image, layer2_landscape_image, layer2_portrait_image, 
            layer3_opacity, layer3_blend_mode, layer3_landscape_preview_image, 
            layer3_portrait_preview_image, layer3_landscape_image, layer3_portrait_image, 
            package, release, created_at, updated_at, filter_type)
    VALUES ('4','Toronto','1',0.55,'Color','Filters-101208_FH_DarkSkies_BW_Color_55_276x207.png','Filters-101208_FH_DarkSkies_BW_Color_55_200x266.png','Filters-101208_FH_DarkSkies_BW_Color_55_600x450.png','Filters-101208_FH_DarkSkies_BW_Color_55_450x600.png',0.6,'Multiply','Filters-101208_FH_DarkSkies_CloudyCorners_Multply_60_276x207.png','Filters-101208_FH_DarkSkies_CloudyCorners_Multply_60_200x266.png','Filters-101208_FH_DarkSkies_CloudyCorners_Multply_60_600x450.png','Filters-101208_FH_DarkSkies_CloudyCorners_Multply_60_450x600.png',1,'Screen','Filters-101208_FH_DarkSkies_ScratchedBorder_Screen_100_276x207.png','Filters-101208_FH_DarkSkies_ScratchedBorder_Screen_100_200x266.png','Filters-101208_FH_DarkSkies_ScratchedBorder_Screen_100_600x450.png','Filters-101208_FH_DarkSkies_ScratchedBorder_Screen_100_450x600.png','',1.6,NULL,NULL,'');
INSERT INTO filters(
            id, name, version, layer1_opacity, layer1_blend_mode, layer1_landscape_preview_image, 
            layer1_portrait_preview_image, layer1_landscape_image, layer1_portrait_image, 
            layer2_opacity, layer2_blend_mode, layer2_landscape_preview_image, 
            layer2_portrait_preview_image, layer2_landscape_image, layer2_portrait_image, 
            layer3_opacity, layer3_blend_mode, layer3_landscape_preview_image, 
            layer3_portrait_preview_image, layer3_landscape_image, layer3_portrait_image, 
            package, release, created_at, updated_at, filter_type)
    VALUES ('5','Chicago','1',1,'Multiply','Filters-101208_FH_FlashBW_Border_Multiply_100_276x207.png','Filters-101208_FH_FlashBW_Border_Multiply_100_200x266.png','Filters-101208_FH_FlashBW_Border_Multiply_100_600x450.png','Filters-101208_FH_FlashBW_Border_Multiply_100_450x600.png',1,'Overlay','Filters-101208_FH_FlashBW_BW_Overlay_100_276x207.png','Filters-101208_FH_FlashBW_BW_Overlay_100_200x266.png','Filters-101208_FH_FlashBW_BW_Overlay_100_600x450.png','Filters-101208_FH_FlashBW_BW_Overlay_100_450x600.png',1,'Color','Filters-101208_FH_FlashBW_BW_Color_100_276_207.png','Filters-101208_FH_FlashBW_BW_Color_100_200_266.png','Filters-101208_FH_FlashBW_BW_Color_100_600_450.png','Filters-101208_FH_FlashBW_BW_Color_100_450_600.png','',1.6,NULL,NULL,'');
INSERT INTO filters(
            id, name, version, layer1_opacity, layer1_blend_mode, layer1_landscape_preview_image, 
            layer1_portrait_preview_image, layer1_landscape_image, layer1_portrait_image, 
            layer2_opacity, layer2_blend_mode, layer2_landscape_preview_image, 
            layer2_portrait_preview_image, layer2_landscape_image, layer2_portrait_image, 
            layer3_opacity, layer3_blend_mode, layer3_landscape_preview_image, 
            layer3_portrait_preview_image, layer3_landscape_image, layer3_portrait_image, 
            package, release, created_at, updated_at, filter_type)
    VALUES ('7','New York','1',1,'Normal','Filters-101208_FH_Polaroid_Instant_Normal_100_276x207.png','Filters-101208_FH_Polaroid_Instant_Normal_100_200x266.png','Filters-101208_FH_Polaroid_Instant_Normal_100_600x450.png','Filters-101208_FH_Polaroid_Instant_Normal_100_450x600.png',NULL,'','','','','',NULL,'','','','','','',1.6,NULL,NULL,'');
INSERT INTO filters(
            id, name, version, layer1_opacity, layer1_blend_mode, layer1_landscape_preview_image, 
            layer1_portrait_preview_image, layer1_landscape_image, layer1_portrait_image, 
            layer2_opacity, layer2_blend_mode, layer2_landscape_preview_image, 
            layer2_portrait_preview_image, layer2_landscape_image, layer2_portrait_image, 
            layer3_opacity, layer3_blend_mode, layer3_landscape_preview_image, 
            layer3_portrait_preview_image, layer3_landscape_image, layer3_portrait_image, 
            package, release, created_at, updated_at, filter_type)
    VALUES ('6','Sao Paulo','1',1,'Normal','Filters-101208_FH_OldColorFilm_Film_Normal_100_276x207.png','Filters-101208_FH_OldColorFilm_Film_Normal_100_200x266.png','Filters-101208_FH_OldColorFilm_Film_Normal_100_600x450.png','Filters-101208_FH_OldColorFilm_Film_Normal_100_450x600.png',1,'Overlay','Filters-101208_FH_OldColorFilm_ChemFilm_Overlay_100_276x207.png','Filters-101208_FH_OldColorFilm_ChemFilm_Overlay_100_200x266.png','Filters-101208_FH_OldColorFilm_ChemFilm_Overlay_100_600x450.png','Filters-101208_FH_OldColorFilm_ChemFilm_Overlay_100_450x600.png',NULL,'','','','','','',1.6,NULL,NULL,'');
INSERT INTO filters(
            id, name, version, layer1_opacity, layer1_blend_mode, layer1_landscape_preview_image, 
            layer1_portrait_preview_image, layer1_landscape_image, layer1_portrait_image, 
            layer2_opacity, layer2_blend_mode, layer2_landscape_preview_image, 
            layer2_portrait_preview_image, layer2_landscape_image, layer2_portrait_image, 
            layer3_opacity, layer3_blend_mode, layer3_landscape_preview_image, 
            layer3_portrait_preview_image, layer3_landscape_image, layer3_portrait_image, 
            package, release, created_at, updated_at, filter_type)
VALUES ('8','Bordeaux','1',1,'Normal','Filters-101208_FH_VintagePrint_Border_Normal_100_276x207.png','Filters-101208_FH_VintagePrint_Border_Normal_100_200x266.png','Filters-101208_FH_VintagePrint_Border_Normal_100_600x450.png','Filters-101208_FH_VintagePrint_Border_Normal_100_450x600.png',1,'Color','Filters-101208_FH_VintagePrint_Color_100_276x207.png','Filters-101208_FH_VintagePrint_Color_100_200x266.png','Filters-101208_FH_VintagePrint_Color_100_600x450.png','Filters-101208_FH_VintagePrint_Color_100_450x600.png',0.5,'Lighten','Filters-101208_FH_VintagePrint_Lighten_50_276x207.png','Filters-101208_FH_VintagePrint_Lighten_50_200x266.png','Filters-101208_FH_VintagePrint_Lighten_50_600x450.png','Filters-101208_FH_VintagePrint_Lighten_50_450x600.png','',1.6,NULL,NULL,'');

ENDOFSQL
  end

  def self.down
  end
end
