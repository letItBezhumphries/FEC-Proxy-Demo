#!/bin/bash

# Project directories
PROXY_DIR="fec-demo/node-demo"
PHOTOGALLERY_DIR="fec-demo/photogallery-demo"
RESTAURANT_INFO_DIR="fec-demo/restaurant-info-demo"
REVIEWS_DIR="fec-demo/reviews-demo"

# check the working directory and start the proxy-server
npm start & 
cd ../photogallery-demo && npm start &
cd ../restaurant-info-demo && npm start & 
cd ../reviews-demo && npm start 