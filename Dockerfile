Use an official Node.js runtime as a parent image
FROM node:14

Set the working directory inside the container
WORKDIR /usr/src/app

Copy package.json and package-lock.json to the working directory
COPY package*.json ./

Install dependencies
RUN npm install

Copy the rest of the application files
COPY . .

Expose the application port (8080)
EXPOSE 8080

Start the application
CMD ["node", "server.js"]
