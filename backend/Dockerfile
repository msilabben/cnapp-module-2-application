FROM python:3.11-slim

WORKDIR /app

RUN pip install --no-cache-dir uv

COPY pyproject.toml uv.lock* ./
RUN uv sync --dev

# Create a system group and user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

COPY . .

EXPOSE 8000

CMD ["uv", "run", "uvicorn", "app.main:create_app", "--factory", "--host", "0.0.0.0", "--port", "8000"]