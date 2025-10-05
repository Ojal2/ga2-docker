# Base image
FROM python:3.11-slim

# Create user (UID 1000 for Hugging Face compatibility)
RUN useradd -m -u 1000 user

# Set working directory
WORKDIR /home/user/app

# Copy requirements and install
COPY --chown=user requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy code
COPY --chown=user . .

# Switch to non-root user
USER user

# Expose port
EXPOSE 7064

# Run the FastAPI app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7064"]
