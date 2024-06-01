FROM python:latest
WORKDIR /app
RUN pip install poetry 
RUN poetry config virtualenvs.create false
COPY ./poetry.lock .
COPY ./pyproject.toml .
RUN poetry install --no-dev
COPY . .
EXPOSE 8000
ENTRYPOINT ["uvicorn", "main:app", "--host", "0.0.0.0"]
CMD ["--port", "80"]
