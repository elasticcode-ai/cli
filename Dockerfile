FROM python:3.12

RUN apt-get update

WORKDIR /opt/pyfi

ENV TZ=America/New_York

ADD requirements.txt /opt/pyfi/requirements.txt
ADD setup.py /opt/pyfi/setup.py
ADD README.md /opt/pyfi/README.md
ADD conf/pyfi.ini /opt/pyfi/pyfi.ini
ADD conf/pyfi.ini /root/pyfi.ini
ADD conf/pyfi.ini /home/pyfi/pyfi.ini
ADD pyfi.polar /root/pyfi.polar

RUN pip3 install virtualenv

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

RUN useradd pyfi -d /home/pyfi
RUN chown -R pyfi /opt/pyfi /home/pyfi
RUN virtualenv --python=python3 venv
RUN venv/bin/python -m pip install --upgrade pip
RUN venv/bin/pip uninstall -y setuptools
RUN venv/bin/pip install setuptools==59.1.1
#RUN venv/bin/pip install --upgrade flask
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip uninstall -y pytz
RUN venv/bin/python setup.py install

