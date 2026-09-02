FROM nginx:alpine

# Remove the default nginx page
RUN rm -rf /usr/share/nginx/html/*

# Copy the application
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
