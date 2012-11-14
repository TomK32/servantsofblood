
require('views/view')
require('views/job_status_view')
require('views/jobs_view')
require('views/map_view')
require('views/menu_view')
require('views/inspector_view')

class "GUIMain" {
  game_state = nil,
  map_view = nil,
  job_status_view = nil,
  jobs_view = nil,
  inspector_view = nil,
  menu_view = nil,
  map_view = nil,
  focused_view = nil,

  __init__ = function(self, game_state)
    self.game_state = game_state
    self.menu_view = MenuView()
    self.jobs_view = JobsView(game_state.jobs)
    self.job_status_view = JobStatusView(game_state.jobs)
    self.inspector_view = InspectorView()
    self.map_view = MapView(game_state.map)
    self.focused_view = nil
  end,

  setFocus = function(self, focus)
    self.focused_view = nil
    if focus == 'jobs' then
      self.focused_view = self.jobs_view
    elseif focus == 'inspector' then
      self.focused_view = self.inspector_view
    end
  end,

  update = function(self, dt)
    if self.focused_view and self.focused_view.navigatable then
      if dt_since_last_move + dt > 0.1 then
        if love.keyboard.isDown('+', '-', 'pageup', 'pagedown') then
          dt_since_last_move = 0
        end
        num = false
        if love.keyboard.isDown('+') then
          num = -1
        elseif love.keyboard.isDown('-') then
          num = 1
        elseif love.keyboard.isDown('pageup') then
          num = 5
        elseif love.keyboard.isDown('pagedown') then
          num = -5
        end
        if (num) then
          if love.keyboard.isDown('rshift', 'lshift') then
            num = num * 5
          end
          self.focused_view:moveCursor(num)
        end
      end
    end
  end,

  draw = function(self)
    love.graphics.push()
    self.map_view.draw_cursor = false
    if self.game_state.focus == 'inspector' then
      self.map_view.draw_cursor = true
      self.inspector_view.list_entries = self.map_view:currentTile().entities
      self.inspector_view:draw()
    elseif self.game_state.focus == 'jobs' then
      self.jobs_view:draw()
    else
      self.menu_view:draw()
    end
    self.map_view:draw()
    love.graphics.pop()
  end
}
