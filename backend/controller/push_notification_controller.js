const admin = require("firebase-admin");
const fcm = require("fcm-node");
const fs = require("fs");
const path = require("path");



const fcmT = new fcm("AAAAox0zztM:APA91bHmuJDwH_dtAo9S5c1EGzIxHVJGVouLieIV1-7XUfvBknNZx_X2WOvPjLnzcL57PQNSDU49_cmxaDQgEfeVXDkkN63iLQjgMBuEi1iSqPq5AoD7Uz24QGAhvZHGxBEHspAJPlz3");
const message = {
    notification: {
        title: "HLw",
        body: "hlw"
    },
    data: {
        type: "msg",
    },
    to: "e6njUTmaScG36TJeYBjUJG:APA91bFqkGtkHrHsHOT7ddNtOPv0DhBhm9kYyfAnOWovfgWpg-RZuMDQ-dCLb9WWsl3Fk6kuPAqR5d1cxrZFJgqYksKaK1MhhS7vMXo5QI2BxGRyHaj3uc8VEPSJ_Pv1H4RUaoBd1Cxg",
}
exports.notification = () => {
    fcmT.send(message, function (err, res) {
        if (err) {
            console.log(err);
        }
        else {
            console.log("success");
        }
    })
}