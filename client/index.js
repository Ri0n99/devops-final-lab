const express = require("express");
const app = express();
const PORT = 5000;

app.get("/", (req, res) => {
  res.send("Client running!");
});

app.listen(PORT, () => console.log(`Client on port ${PORT}`));
