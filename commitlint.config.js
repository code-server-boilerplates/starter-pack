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