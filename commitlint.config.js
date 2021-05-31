module.exports = {
    // yes, our apologies to Angular haters for this BS
    extends: ["@commitlint/config-conventional"],
    rules: {
      "scope-enum": [
        2,
        "always",
        [
          "global",
          "helm-charts", // BUILD, FEAT, or CHORE
          "github-actions", // CI, BUILD, or CHORE
          "mergify-config",
          "deps", // CI, CHORE
          "deps-dev", // CI, CHORE
          "deps-peer", // CI, CHORE
          "dpes-optional", // CI, CHORE
          "commitlint", // CI, CHORE
          "commitizen", // mostly CHORE
          "toolkits/containers",
          "toolkits/virtual-machines",
          "github-org-files", // CHORE
          "deployment-guides", // DOCS
          "dockerfiles", // FIX, CHORE, or FEAT
          "toolkits-packages/scripts",
          "toolkits-packages/nonsense-bullshit" // probably for our example packages
        ],
      ],
    },
  };
