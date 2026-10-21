hl.config ({
    general = {
        col = {
            active_border = {
                colors = {
                    "rgba({{color1 | saturate(0.6) | strip}}ee)",
                    "rgba({{color2 | saturate(0.6) | strip}}ee)",
                    "rgba({{color3 | saturate(0.6) | strip}}ee)",
                    "rgba({{color4 | saturate(0.6) | strip}}ee)",
                    "rgba({{color5 | saturate(0.6) | strip}}ee)",
                    "rgba({{color6 | saturate(0.6) | strip}}ee)",
                },
                angle = 45,
            },
            inactive_border = "rgba({{color0 | strip}}ee)",
        },
    },
})
