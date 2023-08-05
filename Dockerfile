FROM docker.io/python:3.11-alpine
# 기본적으로 콘테이너 이미지는 아무것도 없음

WORKDIR /app

COPY requirements.txt ./
# docker 콘테이너 이미지가 빌드되고 있는 경로에 복사
# 복사해야 파이썬 코드를 콘테이너 이미지에 넣을 수 있음

RUN pip install -r requirements.txt --no-cache-dir --disable-pip-version-check
# 복사한 파일을 설치

ARG DJANGO_SETTINGS_MODULE
ENV DJANGO_SETTINGS_MODULE ${DJANGO_SETTINGS_MODULE:-server.settings}

# RUN python server/manage.py collectstatic

COPY ./ /app

EXPOSE 8000

WORKDIR /app/server

CMD ["gunicorn", "server.asgi:application", "-c", "conf.d/gunicorn.conf.py"]