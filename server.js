const http = require('http');
const fs = require('fs').promises;
const mime = require('mime-types');
const url = require('url');

const hostname = '127.0.0.1';
const port = 7000;

const server = http.createServer((req, res) => {
	let filePath = req.url;
	const subdomain = req.headers.host.split('.')[0];
	// subdomains
	if (subdomain === 'app') {
		filePath = '/app/app.html';
	}
	// standard route
	if (filePath === '/') {
		filePath = '/app/index/index.html';
	}

	fs.readFile(__dirname + filePath)
		.then(contents => {
			const contentType = mime.lookup(filePath);
			res.setHeader("Content-Type", contentType);
			res.writeHead(200);
			res.end(contents);
		})
		.catch(err => {
			fs.readFile(__dirname + '/app/404.html')
				.then(contents => {
					res.setHeader("Content-Type", "text/html");
					res.writeHead(404);
					res.end(contents);
				})
				.catch(err => {
					res.writeHead(500);
					console.log(err);
					res.end(JSON.stringify(err));
					return;
				});
		});
});

server.listen(port, hostname, () => {
	console.log(`Server running at http://${hostname}:${port}/`);
});