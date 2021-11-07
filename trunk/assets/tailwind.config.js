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
      linkedin: "#3b5998",
      twitter: "#1da1f2",
      primary: '#a801a1',
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