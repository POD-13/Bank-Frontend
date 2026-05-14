FROM node:18-alpine



COPY . .

RUN npm install --save-dev @babel/plugin-proposal-private-property-in-object
RUN npm install --save react react-dom @types/react @types/react-dom
RUN npm install react-scripts@3.0.1  --save
RUN npm install
COPY . .
RUN npm run build

# Stage 2 — Servve with nginx
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=builder /app/build .
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]