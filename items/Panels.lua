---
--- @author Dylan MALANDAIN, Kalyptus
--- @version 1.0.0
--- created at [24/05/2021 10:02]
---

---@class Panels
Panels = {};

local GridType = {
    Default = 1,
    Horizontal = 2,
    Vertical = 3
}

local GridSprite = {
    [GridType.Default] = { Dictionary = "pause_menu_pages_char_mom_dad", Texture = "nose_grid", },
    [GridType.Horizontal] = { Dictionary = "RageUI_", Texture = "horizontal_grid", },
    [GridType.Vertical] = { Dictionary = "RageUI_", Texture = "vertical_grid", },
}

local Grid = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 275 },
    Grid = { X = 115.5, Y = 47.5, Width = 200, Height = 200 },
    Circle = { Dictionary = "mpinventory", Texture = "in_world_circle", X = 115.5, Y = 47.5, Width = 20, Height = 20 },
    Text = {
        Top = { X = 215.5, Y = 15, Scale = 0.35 },
        Bottom = { X = 215.5, Y = 250, Scale = 0.35 },
        Left = { X = 57.75, Y = 130, Scale = 0.35 },
        Right = { X = 373.25, Y = 130, Scale = 0.35 },
    },
}

local function UIGridPanel(Type, StartedX, StartedY, TopText, BottomText, LeftText, RightText, Action, Index)
    local CurrentMenu = RageUI.CurrentMenu
    if (CurrentMenu.Index == Index) then
        local X = Type == GridType.Default and StartedX or Type == GridType.Horizontal and StartedX or Type == GridType.Vertical and 0.5
        local Y = Type == GridType.Default and StartedY or Type == GridType.Horizontal and 0.5 or Type == GridType.Vertical and StartedY
        local Hovered = Graphics.IsMouseInBounds(CurrentMenu.X + Grid.Grid.X + CurrentMenu.SafeZoneSize.X + 20, CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20, Grid.Grid.Width + CurrentMenu.WidthOffset - 40, Grid.Grid.Height - 40)
        local Selected = false
        local CircleX = CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20
        local CircleY = CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20
        if X < 0.0 or X > 1.0 then
            X = 0.0
        end
        if Y < 0.0 or Y > 1.0 then
            Y = 0.0
        end
        CircleX = CircleX + ((Grid.Grid.Width - 40) * X) - (Grid.Circle.Width / 2)
        CircleY = CircleY + ((Grid.Grid.Height - 40) * Y) - (Grid.Circle.Height / 2)
        Graphics.Sprite("commonmenu", "gradient_bgd", CurrentMenu.X, CurrentMenu.Y + Grid.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Grid.Background.Width + CurrentMenu.WidthOffset, Grid.Background.Height)
        Graphics.Sprite(GridSprite[Type].Dictionary, GridSprite[Type].Texture, CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Grid.Grid.Width, Grid.Grid.Height)
        Graphics.Sprite(Grid.Circle.Dictionary, Grid.Circle.Texture, CircleX, CircleY, Grid.Circle.Width, Grid.Circle.Height)
        if (Type == GridType.Default) then
            Graphics.Text(TopText or "", CurrentMenu.X + Grid.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Top.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Top.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(BottomText or "", CurrentMenu.X + Grid.Text.Bottom.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Bottom.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Bottom.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(LeftText or "", CurrentMenu.X + Grid.Text.Left.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Left.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(RightText or "", CurrentMenu.X + Grid.Text.Right.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Right.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Right.Scale, 245, 245, 245, 255, 1)
        end
        if (Type == GridType.Vertical) then
            Graphics.Text(TopText or "", CurrentMenu.X + Grid.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Top.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Top.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(BottomText or "", CurrentMenu.X + Grid.Text.Bottom.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Bottom.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Bottom.Scale, 245, 245, 245, 255, 1)
        end
        if (Type == GridType.Horizontal) then
            Graphics.Text(LeftText or "", CurrentMenu.X + Grid.Text.Left.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Left.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(RightText or "", CurrentMenu.X + Grid.Text.Right.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Grid.Text.Right.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Grid.Text.Right.Scale, 245, 245, 245, 255, 1)
        end
        if Hovered then
            if IsDisabledControlPressed(0, 24) then
                Selected = true
                CircleX = math.round(GetControlNormal(2, 239) * 1920) - CurrentMenu.SafeZoneSize.X - (Grid.Circle.Width / 2)
                CircleY = math.round(GetControlNormal(2, 240) * 1080) - CurrentMenu.SafeZoneSize.Y - (Grid.Circle.Height / 2)
                if CircleX > (CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20 + Grid.Grid.Width - 40) then
                    CircleX = CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20 + Grid.Grid.Width - 40
                elseif CircleX < (CurrentMenu.X + Grid.Grid.X + 20 - (Grid.Circle.Width / 2)) then
                    CircleX = CurrentMenu.X + Grid.Grid.X + 20 - (Grid.Circle.Width / 2)
                end
                if CircleY > (CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20 + Grid.Grid.Height - 40) then
                    CircleY = CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20 + Grid.Grid.Height - 40
                elseif CircleY < (CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20 - (Grid.Circle.Height / 2)) then
                    CircleY = CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20 - (Grid.Circle.Height / 2)
                end
                X = math.round((CircleX - (CurrentMenu.X + Grid.Grid.X + (CurrentMenu.WidthOffset / 2) + 20) + (Grid.Circle.Width / 2)) / (Grid.Grid.Width - 40), 2)
                Y = math.round((CircleY - (CurrentMenu.Y + Grid.Grid.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + 20) + (Grid.Circle.Height / 2)) / (Grid.Grid.Height - 40), 2)
                if (X ~= StartedX) and (Y ~= StartedY) then
                    Action(X, Y, (X * 2 - 1), (Y * 2 - 1))
                    --	Action.onPositionChange(X, Y, (X * 2 - 1), (Y * 2 - 1))
                end
                StartedX = X;
                StartedY = Y;
                if X > 1.0 then
                    X = 1.0
                end
                if Y > 1.0 then
                    Y = 1.0
                end
            end
        end
        RageUI.ItemOffset = RageUI.ItemOffset + Grid.Background.Height + Grid.Background.Y
        if Hovered and Selected then
            Audio.PlaySound(RageUI.Settings.Audio.Slider.audioName, RageUI.Settings.Audio.Slider.audioRef, true)
            --if (Action.onSelected ~= nil) then
            --	Action.onSelected(X, Y, (X * 2 - 1), (Y * 2 - 1));
            --end
        end
    end
end

---Grid
---@param StartedX number
---@param StartedY number
---@param TopText string
---@param BottomText string
---@param LeftText string
---@param RightText string
---@param Action fun(X:number, Y:number, CharacterX:number, CharacterY:number)
---@param Index number
---@public
---@return void
function Panels:Grid(StartedX, StartedY, TopText, BottomText, LeftText, RightText, Action, Index)
    UIGridPanel(GridType.Default, StartedX, StartedY, TopText, BottomText, LeftText, RightText, Action, Index)
end

---GridHorizontal
---@param StartedX number
---@param LeftText string
---@param RightText string
---@param Action fun(X:number, Y:number, CharacterX:number, CharacterY:number)
---@param Index number
---@public
---@return void
function Panels:GridHorizontal(StartedX, LeftText, RightText, Action, Index)
    UIGridPanel(GridType.Horizontal, StartedX, nil, nil, nil, LeftText, RightText, Action, Index)
end

---GridVertical
---@param StartedY number
---@param TopText string
---@param BottomText string
---@param Action fun(X:number, Y:number, CharacterX:number, CharacterY:number)
---@param Index number
---@public
---@return void
function Panels:GridVertical(StartedY, TopText, BottomText, Action, Index)
    UIGridPanel(GridType.Vertical, nil, StartedY, TopText, BottomText, nil, nil, Action, Index)
end

---PercentagePanel
---@param Percent number
---@param HeaderText string
---@param MinText string
---@param MinText string
---@param Actions fun(Hovered:boolean, Selected:boolean, Percent:number)
---@param Index number
---@public
---@return void
function Panels:PercentagePanel(Percent, HeaderText, MinText, MaxText, Actions, Index)
    local CurrentMenu = RageUI.CurrentMenu
    
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            if Index ~= nil and CurrentMenu.Index ~= Index then
                return
            end
            local Hovered = false
            local Selected = false
            
            if CurrentMenu.EnableMouse then
                Hovered = Graphics.IsMouseInBounds(CurrentMenu.X + RageUI.Settings.Panels.Percentage.Bar.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + RageUI.Settings.Panels.Percentage.Bar.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset - 4, RageUI.Settings.Panels.Percentage.Bar.Width + CurrentMenu.WidthOffset, RageUI.Settings.Panels.Percentage.Bar.Height + 8)
            end
            
            local Progress = RageUI.Settings.Panels.Percentage.Bar.Width
            
            if Percent < 0.0 then
                Percent = 0.0
            elseif Percent > 1.0 then
                Percent = 1.0
            end
            
            Progress = Progress * Percent
            
            Graphics.Sprite(RageUI.Settings.Panels.Percentage.Background.Dictionary, RageUI.Settings.Panels.Percentage.Background.Texture, CurrentMenu.X, CurrentMenu.Y + RageUI.Settings.Panels.Percentage.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, RageUI.Settings.Panels.Percentage.Background.Width + CurrentMenu.WidthOffset, RageUI.Settings.Panels.Percentage.Background.Height)
            
            Graphics.Rectangle(CurrentMenu.X + RageUI.Settings.Panels.Percentage.Bar.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + RageUI.Settings.Panels.Percentage.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, RageUI.Settings.Panels.Percentage.Bar.Width, RageUI.Settings.Panels.Percentage.Bar.Height, 87, 87, 87, 255)
            
            Graphics.Rectangle(CurrentMenu.X + RageUI.Settings.Panels.Percentage.Bar.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + RageUI.Settings.Panels.Percentage.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Progress, RageUI.Settings.Panels.Percentage.Bar.Height, 245, 245, 245, 255)
            
            Graphics.Text(HeaderText or "Opacity", CurrentMenu.X + RageUI.Settings.Panels.Percentage.Text.Middle.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + RageUI.Settings.Panels.Percentage.Text.Middle.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, RageUI.Settings.Panels.Percentage.Text.Middle.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(MinText or "0%", CurrentMenu.X + RageUI.Settings.Panels.Percentage.Text.Left.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + RageUI.Settings.Panels.Percentage.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, RageUI.Settings.Panels.Percentage.Text.Left.Scale, 245, 245, 245, 255, 1)
            Graphics.Text(MaxText or "100%", CurrentMenu.X + RageUI.Settings.Panels.Percentage.Text.Right.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + RageUI.Settings.Panels.Percentage.Text.Right.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, RageUI.Settings.Panels.Percentage.Text.Right.Scale, 245, 245, 245, 255, 1)
            
            if Hovered then
                if IsDisabledControlPressed(0, 24) then
                    Selected = true
                    
                    Progress = math.round(GetControlNormal(0, 239) * 1920) - CurrentMenu.SafeZoneSize.X - (CurrentMenu.X + RageUI.Settings.Panels.Percentage.Bar.X + (CurrentMenu.WidthOffset / 2))
                    
                    if Progress < 0 then
                        Progress = 0
                    elseif Progress > (RageUI.Settings.Panels.Percentage.Bar.Width) then
                        Progress = RageUI.Settings.Panels.Percentage.Bar.Width
                    end
                    
                    Percent = math.round(Progress / RageUI.Settings.Panels.Percentage.Bar.Width, 2)
                end
            end
            
            RageUI.ItemOffset = RageUI.ItemOffset + RageUI.Settings.Panels.Percentage.Background.Height + RageUI.Settings.Panels.Percentage.Background.Y
            
            if Hovered and Selected then
                Audio.PlaySound(RageUI.Settings.Audio.Slider.audioName, RageUI.Settings.Audio.Slider.audioRef, true)
            end
            
            Actions(Hovered, Selected, Percent)
        end
    end
end

---StatisticPanel
---@param Percent number
---@param Text string
---@param Index number
---@return void
---@public
function Panels:StatisticPanel(Percent, Text, Index)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            if Index ~= nil and CurrentMenu.Index ~= Index then
                return
            end
            local Statistics = {
                Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 42 },
                Text = {
                    Left = { X = 15, Y = 15, Scale = 0.35 },
                },
                Bar = { X = 150, Y = 27, Width = 200, Height = 10 },
                Divider = {
                    [1] = { X = 160, Y = 27, Width = 2, Height = 10 },
                    [2] = { X = 200, Y = 27, Width = 2, Height = 10 },
                    [3] = { X = 240, Y = 27, Width = 2, Height = 10 },
                    [4] = { X = 280, Y = 27, Width = 2, Height = 10 },
                    [5] = { X = 320, Y = 27, Width = 2, Height = 10 },
                }
            }
            
            Graphics.Rectangle(CurrentMenu.X, CurrentMenu.Y + Statistics.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + (RageUI.StatisticPanelCount * 42), Statistics.Background.Width + CurrentMenu.WidthOffset, Statistics.Background.Height, 0, 0, 0, 170)
            Graphics.Text(Text or "", CurrentMenu.X + Statistics.Text.Left.X + (CurrentMenu.WidthOffset / 2), (RageUI.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, Statistics.Text.Left.Scale, 245, 245, 245, 255, 0)
            Graphics.Rectangle(CurrentMenu.X + Statistics.Bar.X + (CurrentMenu.WidthOffset / 2), (RageUI.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Statistics.Bar.Width, Statistics.Bar.Height, 87, 87, 87, 255)
            Graphics.Rectangle(CurrentMenu.X + Statistics.Bar.X + (CurrentMenu.WidthOffset / 2), (RageUI.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Bar.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Percent * Statistics.Bar.Width, Statistics.Bar.Height, 255, 255, 255, 255)
            
            for i = 1, #Statistics.Divider, 1 do
                Graphics.Rectangle(CurrentMenu.X + Statistics.Divider[i].X + (CurrentMenu.WidthOffset / 2), (RageUI.StatisticPanelCount * 40) + CurrentMenu.Y + Statistics.Divider[i].Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Statistics.Divider[i].Width, Statistics.Divider[i].Height, 0, 0, 0, 255)
            end
            
            RageUI.StatisticPanelCount = RageUI.StatisticPanelCount + 1
        end
    end
end

---ColourPanel
---@param Title string
---@param Colours thread
---@param MinimumIndex number
---@param CurrentIndex number
---@param Callback function
---@param Index number
---@return nil
---@public
function Panels:ColourPanel(Title, Colours, MinimumIndex, CurrentIndex, Callback, Index)
    local CurrentMenu = RageUI.CurrentMenu;
    
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            if Index ~= nil and CurrentMenu.Index ~= Index then
                return
            end
            local Colour = {
                Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 112 },
                LeftArrow = { Dictionary = "commonmenu", Texture = "arrowleft", X = 7.5, Y = 15, Width = 30, Height = 30 },
                RightArrow = { Dictionary = "commonmenu", Texture = "arrowright", X = 393.5, Y = 15, Width = 30, Height = 30 },
                Header = { X = 215.5, Y = 15, Scale = 0.35 },
                Box = { X = 15, Y = 55, Width = 44.5, Height = 44.5 },
                SelectedRectangle = { X = 15, Y = 47, Width = 44.5, Height = 8 },
            }
            
            local Maximum = (#Colours > 9) and 9 or #Colours
            
            local Hovered = false
            local LeftArrowHovered = false
            local RightArrowHovered = false
            
            if CurrentMenu.EnableMouse then
                Hovered = Graphics.IsMouseInBounds(CurrentMenu.X + Colour.Box.X + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.Box.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, (Colour.Box.Width * Maximum), Colour.Box.Height)
                LeftArrowHovered = Graphics.IsMouseInBounds(CurrentMenu.X + Colour.LeftArrow.X + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.LeftArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.LeftArrow.Width, Colour.LeftArrow.Height)
                RightArrowHovered = Graphics.IsMouseInBounds(CurrentMenu.X + Colour.RightArrow.X + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.RightArrow.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.RightArrow.Width, Colour.RightArrow.Height)
            end
            
            local Selected = false
            
            Graphics.Sprite(Colour.Background.Dictionary, Colour.Background.Texture, CurrentMenu.X, CurrentMenu.Y + Colour.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.Background.Width + CurrentMenu.WidthOffset, Colour.Background.Height)
            Graphics.Sprite(Colour.LeftArrow.Dictionary, Colour.LeftArrow.Texture, CurrentMenu.X + Colour.LeftArrow.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.LeftArrow.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.LeftArrow.Width, Colour.LeftArrow.Height)
            Graphics.Sprite(Colour.RightArrow.Dictionary, Colour.RightArrow.Texture, CurrentMenu.X + Colour.RightArrow.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.RightArrow.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.RightArrow.Width, Colour.RightArrow.Height)
            
            local RelativeIndex = CurrentIndex - MinimumIndex + 1
            if RelativeIndex >= 1 and RelativeIndex <= Maximum then
                Graphics.Rectangle(CurrentMenu.X + Colour.SelectedRectangle.X + (Colour.Box.Width * (RelativeIndex - 1)) + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.SelectedRectangle.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.SelectedRectangle.Width, Colour.SelectedRectangle.Height, 245, 245, 245, 255)
            end
            
            for Index = 1, Maximum do
                Graphics.Rectangle(CurrentMenu.X + Colour.Box.X + (Colour.Box.Width * (Index - 1)) + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.Box.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.Box.Width, Colour.Box.Height, table.unpack(Colours[MinimumIndex + Index - 1]))
            end
            
            Graphics.Text((Title and Title or "") .. " (" .. CurrentIndex .. " of " .. #Colours .. ")", CurrentMenu.X + RageUI.Settings.Panels.Grid.Text.Top.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + RageUI.Settings.Panels.Grid.Text.Top.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, RageUI.Settings.Panels.Grid.Text.Top.Scale, 245, 245, 245, 255, 1)
            
            if Hovered or LeftArrowHovered or RightArrowHovered then
                if RageUI.Settings.Controls.Click.Active then
                    Selected = true
                    
                    if LeftArrowHovered then
                        CurrentIndex = CurrentIndex - 1
                        
                        if CurrentIndex < 1 then
                            CurrentIndex = #Colours
                            MinimumIndex = #Colours - Maximum + 1
                        elseif CurrentIndex < MinimumIndex then
                            MinimumIndex = CurrentIndex
                        end
                    elseif RightArrowHovered then
                        CurrentIndex = CurrentIndex + 1
                        
                        if CurrentIndex > #Colours then
                            CurrentIndex = 1
                            MinimumIndex = 1
                        elseif CurrentIndex > MinimumIndex + Maximum - 1 then
                            MinimumIndex = CurrentIndex - Maximum + 1
                        end
                    elseif Hovered then
                        for Index = 1, Maximum do
                            if Graphics.IsMouseInBounds(CurrentMenu.X + Colour.Box.X + (Colour.Box.Width * (Index - 1)) + CurrentMenu.SafeZoneSize.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + Colour.Box.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Colour.Box.Width, Colour.Box.Height) then
                                CurrentIndex = MinimumIndex + Index - 1
                            end
                        end
                    end
                end
            end
            
            if CurrentMenu.Controls.Left.Active then
                CurrentIndex = CurrentIndex - 1
                Selected = true
                
                if CurrentIndex < 1 then
                    CurrentIndex = #Colours
                    MinimumIndex = #Colours - Maximum + 1
                elseif CurrentIndex < MinimumIndex then
                    MinimumIndex = CurrentIndex
                end
                
                Audio.PlaySound(RageUI.Settings.Audio.LeftRight.audioName, RageUI.Settings.Audio.LeftRight.audioRef)
            elseif CurrentMenu.Controls.Right.Active then
                CurrentIndex = CurrentIndex + 1
                Selected = true
                
                if CurrentIndex > #Colours then
                    CurrentIndex = 1
                    MinimumIndex = 1
                elseif CurrentIndex > MinimumIndex + Maximum - 1 then
                    MinimumIndex = CurrentIndex - Maximum + 1
                end
                
                Audio.PlaySound(RageUI.Settings.Audio.LeftRight.audioName, RageUI.Settings.Audio.LeftRight.audioRef)
            end
            
            RageUI.ItemOffset = RageUI.ItemOffset + Colour.Background.Height + Colour.Background.Y
            
            if (Hovered or LeftArrowHovered or RightArrowHovered) and RageUI.Settings.Controls.Click.Active then
                Audio.PlaySound(RageUI.Settings.Audio.Select.audioName, RageUI.Settings.Audio.Select.audioRef)
            end
            
            Callback((Hovered or LeftArrowHovered or RightArrowHovered), Selected, MinimumIndex, CurrentIndex)
        end
    end
end