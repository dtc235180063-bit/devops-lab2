const http = require('http');

const server = http.createServer((req, res) => {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({
        message: 'Hello from Docker!',
        lab: 'DevOps Lab 2 — Lean Principle',
        student: 'Nguyễn Văn Hải',
        mssv: 'DTC235180063',
        class: 'KTPMK22C',
        timestamp: new Date().toISOString(),
        node_version: process.version,
        platform: process.platform,
    }, null, 2));
});

const PORT = 3000;
server.listen(PORT, () => {
    console.log(`🚀 Server running at http://localhost:${PORT}`);
    console.log(`Environment: Node.js ${process.version} on ${process.platform}`);
});
