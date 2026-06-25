# -------- Builder stage --------
FROM python:3.9-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# -------- Final image --------
FROM python:3.9-slim

WORKDIR /app

# Create non-root user (BEST PRACTICE)
RUN useradd -m appuser

COPY --from=builder /root/.local /root/.local
COPY src/ ./src

ENV PATH=/root/.local/bin:$PATH

# Switch user
USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget -qO- http://localhost:5000/health || exit 1

CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:5000", "src.app:app"]
