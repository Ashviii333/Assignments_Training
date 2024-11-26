const http = require('http');
const fs = require('fs');
const url = require('url');


const validCredentials = {
  username: 'user',
  password: 'password123',
};


const serveFile = (res, filePath, contentType) => {
  fs.readFile(filePath, (err, data) => {
    if (err) {
      res.writeHead(500, { 'Content-Type': 'text/html' });
      res.end('<h1>500 Internal Server Error</h1>');
    } else {
      res.writeHead(200, { 'Content-Type': contentType });
      res.end(data);
    }
  });
};


const server = http.createServer((req, res) => {
  const parsedUrl = url.parse(req.url, true);
  const pathname = parsedUrl.pathname;
  const query = parsedUrl.query;

  if (pathname === '/' && req.method === 'GET') {
    serveFile(res, './index.html', 'text/html');
  } else if (pathname === '/login' && req.method === 'GET') {
    const { username, password } = query;
    if (username === validCredentials.username && password === validCredentials.password) {
      serveFile(res, './welcome.html', 'text/html');
    } else {
      serveFile(res, './error.html', 'text/html');
    }
  } else {
    res.writeHead(404, { 'Content-Type': 'text/html' });
    res.end('<h1>404 Not Found</h1><a href="/">Go to Login</a>');
  }
});

const PORT = 3000;
server.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
