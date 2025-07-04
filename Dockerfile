FROM python:3.9-slim

WORKDIR /usr/src/app

RUN pip install flask

COPY app.py .

EXPOSE 8080

CMD ["python", "app.py"]
