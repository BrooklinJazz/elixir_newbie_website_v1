const colors = require('tailwindcss/colors')

module.exports = {
  mode: 'jit',
  purge: [
    './js/**/*.js',
    '../lib/*_web/**/*.*ex'
  ],
  theme: {
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      primary: '#a800a1',
      secondary: '#5BDFE4',
      surface: '#0e0e10',
      black: colors.black,
      white: colors.white,
    }
  },
  "headwind.runOnSave": false,
  variants: {},
  plugins: []
};