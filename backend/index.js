const express = require("express");
const { notification } = require("./controller/push_notification_controller.js");

const PORT = 3000;
const app = express();
const route = express.Router();

app.use(express.json());
app.use(route.post("/notification", notification));

app.listen(PORT, () => {
    console.log(`server is running on ${PORT}`);
})