
Entities.Ground = class("Ground")
Entities.Ground:include({
  name = 'Ground',

  initialize = function(self)
    self.name = 'Ground'
  end,

  to_s = function(self)
    return self.name
  end,

  description = function(self)
    return self.name
  end
})
