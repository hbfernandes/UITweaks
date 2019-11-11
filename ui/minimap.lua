-- Minimap
-- https://github.com/tomrus88/BlizzardInterfaceCode/blob/master/Interface/FrameXML/Minimap.xml

if MinimapCluster then
    -- Hide location frame
    MinimapZoneTextButton:Hide()
    MinimapBorderTop:Hide()
    MiniMapWorldMapButton:Hide()

    -- Adjust position
    local point, relativeTo, relativePoint, xofs, yofs = MinimapCluster:GetPoint()
    MinimapCluster:ClearAllPoints()
    MinimapCluster:SetPoint(point, relativeTo, relativePoint, xofs, yofs - 10)

    -- Add Scroll Zoom and hide Zoom buttons
    Minimap:SetScript("OnMouseWheel", function(self, dir)
        if dir < 0 then
            Minimap_ZoomOut()
        else
            Minimap_ZoomIn()
        end
    end)
    Minimap:EnableMouseWheel(true)
    MinimapZoomOut:Hide()
    MinimapZoomIn:Hide()
end
