# Usar a base Node.js completa
FROM node:18

# Definir o caminho do executável para o WPPConnect usar em tempo de execução
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# Instalar o Chromium e suas dependências. O próprio pacote do Chromium
# já inclui as bibliotecas necessárias como libnspr4.
RUN apt-get update && apt-get install -y chromium --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Configurar a aplicação
WORKDIR /usr/src/app

COPY package*.json ./

# Instalar as dependências do Node, passando a instrução para pular o download
# diretamente na linha de comando para garantir que seja executada.
RUN PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true npm install

COPY . .

CMD ["npm", "start"]
