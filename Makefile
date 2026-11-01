PORT ?= 8000

setup: install

install:
	uv sync

build: install

dev:
	uv run flask --debug --app page_analyzer:app run

start:
	uv run gunicorn -w 5 -b 0.0.0.0:$(PORT) page_analyzer:app

render-start:
	uv run gunicorn -w 1 -b 0.0.0.0:$(PORT) page_analyzer:app

lint:
	uv run ruff check .