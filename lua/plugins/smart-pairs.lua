return {
  "ZhiyuanLck/smart-pairs",
  event = 'InsertEnter',
  config = function()
    require('pairs'):setup({
      enter = {
        enable_mapping = false
      }
    })
  end
}
