%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/"],
        excluded: []
      },
      plugins: [],
      requires: [],
      strict: false,
      parse_timeout: 5000,
      color: true,
      checks: [
        {Credo.Check.Design.AliasUsage, priority: :low},
        {Credo.Check.Readability.MultiAlias, priority: :low}
      ]
    }
  ]
}
