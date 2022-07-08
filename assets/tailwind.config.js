const colors = require("tailwindcss/colors");

module.exports = {
  mode: "jit",
  purge: ["./js/**/*.js", "../lib/*_web/**/*.*ex"],
  theme: {
    extend: {
      colors: {
        transparent: "transparent",
        current: "currentColor",
        linkedin: "#3b5998",
        twitter: "#1da1f2",
        primary: "#a801a1",
        secondary: "#5BDFE4",
        // background: "#1C1B1D",
        background: "#4D3E62",
        header: "#1F2028",
        footer: "#1F2028",
        surface: "#1F2028",
        black: colors.black,
        white: colors.white,
      },
      keyframes: {
        "fade-down": {
          "0%": {
            opacity: "0",
            transform: "translateY(-30px)",
          },
          "100%": {
            opacity: "1",
            transform: "translateY(0)",
          },
        },
        "gradient-x": {
          "0%, 100%": {
            "background-size": "200% 200%",
            "background-position": "left center",
          },
          "50%": {
            "background-size": "200% 200%",
            "background-position": "right center",
          },
        },
        "fade-in": {
          "0%": {
            opacity: "0",
            transform: "scale(1.2)",
          },
          "100%": {
            opacity: "1",
            transform: "scale(1)",
          },
        },
      },
      animation: {
        "fade-down": "fade-down 1s",
        "fade-in": "fade-in 1s",
        "gradient-x": "gradient-x 9s ease infinite",
      },
    },
  },
  "headwind.runOnSave": false,
  variants: {},
  plugins: [],
};
