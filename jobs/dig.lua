
Dig = class("Dig", Job)
Dig:include({
  text = "Dig",
  category = "Mining",
  time_required = 2,
  tools_required = {
    Pickaxe = 2
  }
})
