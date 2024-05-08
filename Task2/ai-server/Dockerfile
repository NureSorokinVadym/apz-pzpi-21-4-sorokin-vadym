FROM python:latest
WORKDIR /app
COPY . .
RUN pip install poetry 
RUN poetry config virtualenvs.create false
RUN poetry install --no-dev
EXPOSE 8000
ENTRYPOINT ["uvicorn", "main:app", "--host", "0.0.0.0"]
CMD ["--port", "8000"]
