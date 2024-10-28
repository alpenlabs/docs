import markdownlint from "eslint-plugin-markdownlint";
import eslintConfigPrettier from "eslint-config-prettier";
import parser from "eslint-plugin-markdownlint/parser.js";
import path from "node:path";
import { fileURLToPath } from "node:url";
import js from "@eslint/js";
import { FlatCompat } from "@eslint/eslintrc";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const compat = new FlatCompat({
  baseDirectory: __dirname,
  recommendedConfig: js.configs.recommended,
  allConfig: js.configs.all,
});

export default [
  {
    plugins: {
      markdownlint,
      eslintConfigPrettier,
    },
  },
  ...compat.extends("plugin:markdownlint/recommended").map((config) => ({
    ...config,
    files: ["**/*.md"],
    ignores: [".github/PULL_REQUEST_TEMPLATE.md"],
  })),
  {
    files: ["**/*.md"],

    languageOptions: {
      parser,
    },

    rules: {
      "markdownlint/md033": "off", // inline HTML
      "markdownlint/md046": "off", // code block style
      "markdownlint/md041": "off", // first line in file
      "markdownlint/md024": [
        "error",
        {
          // duplicate headings
          siblings_only: true,
        },
      ],
    },
  },
];
