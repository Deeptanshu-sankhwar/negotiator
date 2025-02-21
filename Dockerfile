FROM python:3.12

WORKDIR /apps
COPY ./negotiator ./negotiator
COPY ./requirements.txt ./requirements.txt
COPY ./run.sh ./run.sh
RUN pip install -r requirements.txt
CMD [ "./run.sh" ]
