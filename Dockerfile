# Use a non-slim Python image for better library compatibility
FROM python:3.9

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y libgomp1 --only-upgrade && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy application files
COPY . /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Set environment variables for threading and memory
ENV OMP_NUM_THREADS=1
ENV OPENBLAS_NUM_THREADS=1
ENV MKL_NUM_THREADS=1
ENV NUMEXPR_NUM_THREADS=1
ENV PYTORCH_NO_CUDA_MEMORY_POOL=1

# Expose the port used by the application
EXPOSE 8080

# Run the application
CMD ["python", "app.py"]
