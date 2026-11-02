return {
  settings = {
    yaml = {
      schemas = {
        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
          ".gitlab-ci.yml",
          ".gitlab-ci.yaml",
          "**/.gitlab-ci.yml",
          "**/.gitlab-ci.yaml",
        },
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
