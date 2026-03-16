## README

Add a script to the `tests/package.json`.

```sh
{
    "scripts": {
        "generate-tests-commons-init": "bash node_modules/@micro-os-plus/build-helper/maintenance-scripts/generate-commons.sh --init --micro-os-plus",
        "npm-install": "npm install",
        "npm-link-helpers": "npm link @xpack/npm-packages-helper @micro-os-plus/build-helper",
        "deep-clean": "del-cli build node_modules xpacks package-json.json"
    }
}
```

Link the helpers:

```sh
npm run npm-link-helpers
xpm-link-helpers
```

