# Etapa 1: Usar uma imagem base do Python.
FROM python:3.13.5-alpine3.22

# Etapa 2: Definir o diretório de trabalho dentro do contêiner.
# Todos os comandos subsequentes serão executados a partir deste diretório.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências primeiro.
# Isso aproveita o cache de camadas do Docker. Se o requirements.txt não mudar,
# o Docker não precisará reinstalar as dependências em builds futuros.
COPY requirements.txt .

# Etapa 4: Instalar as dependências do projeto.
# A flag --no-cache-dir reduz o tamanho da imagem final.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da sua aplicação para o diretório de trabalho.
COPY . .

# Etapa 6: Expor a porta em que a aplicação será executada.
# O Uvicorn, por padrão, roda na porta 8000.
EXPOSE 8000

# Etapa 7: Definir o comando para iniciar a aplicação quando o contêiner for executado.
# Usamos "0.0.0.0" para que o servidor seja acessível de fora do contêiner.
# O comando `uvicorn app:app` inicia o servidor ASGI com o objeto `app` do arquivo `app.py`.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
