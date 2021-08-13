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
          "mergify-config", "mergify",
          "deps", // CI, CHORE
          "deps-dev", // CI, CHORE
          "deps-peer", // CI, CHORE
          "dpes-optional", // CI, CHORE
          "commitlint", // CI, CHORE
          "commitizen", // mostly CHORE
          "containers", // FIX, CHORE, FEAT
          "virtual-machines", // FIX, FEAT, CHORE
          "github-org-files", // in-repo docs are being deperated, please DO NOT REMOVE to ensure CI aren't failing
          "deployment-guides", // DOCS
          "readme", // DOCS, CHORE
          "lockfiles", // CHORE
          "deployment-guides", // CHORE, DOCS
          "toolkits-packages:scripts",
          "toolkits-packages:dotbashrcdir",
          "toolkits-packages:nonsense-bullshit", // probably for our example packages
          "post-repo-creation", // in-repo docs are being deperated, please DO NOT REMOVE to ensure CI aren't failing
          "issue-templates",
          "issue-labels",
          "pr-templates",
          "husky",
          "ignorefiles",
          "gitpod",
          "vscode"
        ],
      ],
    },
  };
