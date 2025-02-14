# Устанавливаем Node.js и NPM
install_node <- function() {
    # Определяем систему
    os_info <- system("uname -s", intern = TRUE)
    
    if (os_info == "Linux") {
        
        # Загружаем и устанавливаем nvm (Node Version Manager)
        system("curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash", wait = TRUE)
        
        system("export NVM_DIR=\"$HOME/.nvm\" && [ -s \"$NVM_DIR/nvm.sh\" ] && \\. \"$NVM_DIR/nvm.sh\"", wait = TRUE)
        
        # Устанавливаем последнюю LTS версию Node.js
        system("bash -c 'source ~/.bashrc && nvm install --lts'", wait = TRUE)
        
        # Загружаем nvm снова, чтобы убедиться, что он доступен
        system("export NVM_DIR=\"$HOME/.nvm\" && [ -s \"$NVM_DIR/nvm.sh\" ] && \\. \"$NVM_DIR/nvm.sh\"", wait = TRUE)
        
        # Проверяем установку
        node_version <- system("bash -c 'source ~/.bashrc && node -v'", intern = TRUE)
        npm_version <- system("bash -c 'source ~/.bashrc && npm -v'", intern = TRUE)
        
        cat("Node.js version:", node_version, "\n")
        cat("NPM version:", npm_version, "\n")
    } else {
        stop("Этот скрипт поддерживает только Linux")
    }
}

install_node()