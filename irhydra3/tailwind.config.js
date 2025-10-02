/** @type {import('tailwindcss').Config} */
module.exports = {
    content: ['./{lib,web}/**/*.dart'],
    theme: {
        extend: {},
    },
    daisyui: {
        themes: [
          "light",
          "dark",
        ],
      },
    plugins: [require("daisyui")],
};