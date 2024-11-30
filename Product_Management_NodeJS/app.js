const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const userRoutes = require('./routes/user');
const adminRoutes = require('./routes/admin');
const path = require('path');

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

app.use(bodyParser.urlencoded({ extended: true }));
app.use('/user', userRoutes);
app.use('/admin', adminRoutes);
app.use(express.static(path.join(__dirname,'public')));

app.get('/', (req, res) => {
    res.render('index');  
});

app.get('/login/user', (req, res) => {
    res.render('login', { role: 'User' });
});


app.get('/login/admin', (req, res) => {
    res.render('login', { role: 'Admin' });
});

app.post('/login/user', (req, res) => {
    const { username, password } = req.body;
    
    if (username === 'user' && password === 'password') {
        res.redirect('/user/dashboard'); 
    } else {
        res.send('Invalid username or password');
    }
});

app.post('/login/admin', (req, res) => {
    const { username, password } = req.body;
    
    if (username === 'admin' && password === 'password') {
        res.redirect('/admin/dashboard'); 
    } else {
        res.send('Invalid username or password');
    }
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});
