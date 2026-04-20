# ===== User =====
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export BROWSER=firefox

# ===== Wayland =====
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export MOZ_ENABLE_WAYLAND=1
export GTK_USE_PORTAL=1

# ===== System =====
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR"/ssh-agent.socket
