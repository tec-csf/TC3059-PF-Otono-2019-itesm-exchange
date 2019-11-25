const express = require('express');

// Define Express App
const app = express();
const PORT = process.env.PORT || 8080;

// Serve Static Assets
app.use(express.static('public'));
app.use(express.static('images'));
app.use(express.static('js'));
app.use(express.static('css'));

app.listen(PORT, () => {
    console.log('Server connected at:', PORT);
});