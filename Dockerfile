# Образ для деплоя на render. Править его не нужно: сборка зовёт `make build`,
# запуск зовёт `make render-start`, и всё, что меняется по шагам, живёт в Makefile.
FROM python:3.14-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends make nodejs npm postgresql-client \
    && rm -rf /var/lib/apt/lists/*

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

ENV UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_PYTHON_DOWNLOADS=never

WORKDIR /app

COPY . .
RUN make build

CMD ["make", "render-start"]