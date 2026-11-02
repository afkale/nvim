return {
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://raw.githubusercontent.com/compose-spec/compose-go/master/schema/compose-spec.json"] = {
          "docker-compose.yml",
          "docker-compose.yaml",
          "docker-compose.*.yml",
          "docker-compose.*.yaml",
          "compose.yml",
          "compose.yaml",
          "compose.*.yml",
          "compose.*.yaml",
        },
      },
      validate = true,
      format = {
        enable = true,
      },
      completion = true,
      hover = true,
      customTags = {
        "!reference sequence",
        "!env_var scalar",
        "!vault scalar",
      },
      keyOrdering = false,
    },
  },
}
