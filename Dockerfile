# Fase 1: Build da aplicação Go
FROM golang:alpine AS builder

# Define o diretório de trabalho
WORKDIR /app

# Copia o código-fonte da aplicação para o container
COPY . .

# Inicializa o módulo Go
RUN go mod init module-name

# Baixa as dependências do módulo Go
RUN go mod tidy

# Compila o binário com otimizações de tamanho
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o fullcycle

# Fase 2: Imagem final
FROM scratch

# Copia o binário da fase anterior
COPY --from=builder /app/fullcycle /fullcycle

# Define o comando de execução do container
CMD ["/fullcycle"]