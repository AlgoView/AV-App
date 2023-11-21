const http = require('http');
const fs = require('fs').promises;
const url = require('url');
const path = require('path');
const mime = require('mime-types');

const hostname = '127.0.0.1';
const port = 7000;

const server = http.createServer((req, res) => {
	let filePath = url.parse(req.url).pathname;
	if (filePath === '/') {
		filePath = '/app/index/index.html';
	}

	const absoluteFilePath = path.join(__dirname, filePath);

	fs.readFile(absoluteFilePath)
		.then(contents => {
			const contentType = mime.lookup(absoluteFilePath);
			res.setHeader("Content-Type", contentType);
			res.writeHead(200);
			res.end(contents);
		})
		.catch(err => {
			fs.readFile(path.join(__dirname, '/app/404.html'))
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