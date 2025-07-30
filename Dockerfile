# Passo 1: Usar uma base Node.js completa para melhor compatibilidade
FROM node:18

# Passo 2: Definir variáveis de ambiente para o Puppeteer
# Diz para o Puppeteer não baixar sua própria versão do Chrome
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Passo 3: Instalar o Chromium e todas as suas dependências do sistema
# Esta é a forma mais garantida de ter um ambiente funcional
RUN apt-get update \
    && apt-get install -y \
    chromium \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-thai-tlwg \
    fonts-kacst \
    fonts-freefont-ttf \
    libxss1 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Passo 4: Continuar com a configuração da aplicação
WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

CMD ["npm", "start"]
