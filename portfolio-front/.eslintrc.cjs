module.exports = {
  root: true,
  env: {
    browser: true,
    node: true,
  },
  extends: ["@nuxt/eslint-config", "plugin:prettier/recommended"],
  parser: "vue-eslint-parser",
  parserOptions: {
    parser: "@typescript-eslint/parser",
  },
};
