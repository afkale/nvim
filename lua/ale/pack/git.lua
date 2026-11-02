require("gitblame").setup {
  enabled = true,
  date_format = "%Y-%m-%d %H:%M",
  message_when_not_committed = "Uncommitted changes",
  delay = 500,
  virtual_text_column = 1,
}
