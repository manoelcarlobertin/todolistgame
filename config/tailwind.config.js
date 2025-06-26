// config/tailwind.config.js
const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  // ... outras configurações
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
    require('flowbite/plugin') // <-- ADICIONE ESTA LINHA
  ],
  content: [ // <-- ADICIONE O CAMINHO DO FLOWBITE AQUI
    './node_modules/flowbite/**/*.js',
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ]
}