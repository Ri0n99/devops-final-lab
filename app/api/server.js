const express = require('express');
const app = express();

const promClient = require('prom-client');
const collectDefaultMetrics = promClient.collectDefaultMetrics;

collectDefaultMetrics({ timeout: 5000 });

app.get('/metrics', async (req, res) => {
  res.set('Content-Type', promClient.register.contentType);
  res.end(await promClient.register.metrics());
});

app.get('/', (req, res) => {
  res.send('API is working!');
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Magic happens on port ${PORT}`);
});
