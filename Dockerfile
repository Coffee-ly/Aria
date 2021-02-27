FROM node:12.19-slim

ENV USER=aria

# install python and make
RUN apt-get update && \
	apt-get install -y python3 build-essential && \
	apt-get purge -y --auto-remove
	
# create aria user
RUN groupadd -r ${USER} && \
	useradd --create-home --home /home/aria -r -g ${USER} ${USER}
	
# set up volume and user
USER ${USER}
WORKDIR /home/aria

COPY package*.json ./
RUN npm install
VOLUME [ "/home/aria" ]

COPY . .

ENTRYPOINT [ "node", "index.js" ]
