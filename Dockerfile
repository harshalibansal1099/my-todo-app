# Step 1: Node Image का उपयोग करके ऐप बिल्ड करना
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Step 2: Nginx का उपयोग करके ऐप को सर्व (Live) करना
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]docker build -t my-todo-app:v1 .