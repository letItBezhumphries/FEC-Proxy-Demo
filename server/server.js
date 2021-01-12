const express = require('express');
const morgan = require('morgan');
const path = require('path');
const fs = require('fs');
const cors = require('cors');
const app = express();
const port = process.env.PORT || 3000;

fs.writeFileSync(
  `${__dirname}/config/env.js`,
  `var config = ${process.env.CLIENT_ENV};`
);

app.use(morgan('dev'));
app.use(cors());
app.use(express.static(path.join(__dirname, '../public')));
app.use(express.static(path.join(__dirname, '../config')));
app.use('/restaurants/:restaurantId', express.static(path.join(__dirname, '../public')));

app.listen(port, () => {
  console.log(`server running at: ${port}`);
});
