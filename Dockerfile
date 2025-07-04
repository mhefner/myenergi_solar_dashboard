# Use official NGINX base image
FROM nginx:alpine

# Remove default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy your HTML (and any other assets) into the nginx html directory
COPY index.html /usr/share/nginx/html/

# Optionally copy a custom nginx config (skip if default is fine)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# NGINX will run by default via CMD from base image
