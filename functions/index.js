// const ONE_HOUR = 3600000;
const FIVE_MINS = 300000;

const functions = require("firebase-functions");

let URL_PANDASCORE = "https://api.pandascore.co/rl";
const PATH_LEAGUES = "/leagues";
const TOKEN_URL = "?token=" + functions.config().pandascore.key

const Client = require("node-rest-client").Client;
const client = new Client();

const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);

exports.fetchLeaguesWithoutCache = functions.https.onRequest((req, res) => {
  console.log("Fetching Leagues Without Cache");
  var leagues = admin.database().ref("/leagues");
  return request(URL_PANDASCORE + PATH_LEAGUES + TOKEN_URL)
    .then(data => cleanUp(data))
    .then(items => saveInDatabase2(leagues, items))
    .then(items => response(res, items, 201));

});

exports.getLeagues = functions.https.onRequest((req, res) => {
  console.log("Fetching The Leagues");
  var leagues = admin.database().ref("/leagues");
  return leagues
    .once("value")
    .then(snapshot => {
      if (isCacheValid(snapshot)) {
        return response(res, snapshot.val(), 200);
      } else {
        return request(URL_PANDASCORE + PATH_LEAGUES + TOKEN_URL)
          .then(data => cleanUp(data))
          .then(items => save(leagues, items))
          .then(items => response(res, items, 201));
      }
    });
});

function save(databaseRef, items) {
  return databaseRef
    .set({
      date: new Date(Date.now()).toISOString(),
      items: items
    })
    .then(() => {
      return Promise.resolve(items);
    });
}

function saveInDatabase2(databaseRef, items) {
  return databaseRef
    .set({ items: items })
    .then(() => {
      return Promise.resolve(items);
    });
}

function request(url) {
  return new Promise(function (fulfill, reject) {
    client.get(url, function (data, response) {
      fulfill(data)
    })
  });
}

function response(res, items, code) {
  return Promise.resolve(res.status(code)
    .type("application/json")
    .send(items));
}

function isCacheValid(snapshot) {
  return (
    snapshot.exists() &&
    elapsed(snapshot.val().date) < FIVE_MINS
  );
}

function handleCache(snapshot, res, lastEdition) {
  if (snapshot.exists() && elapsed(snapshot.val().date) < FIVE_MINS) {
    console.log("Exist & still valid -> return from DB")
    return res.status(200)
      .type("application/json")
      .send(snapshot.val());

  } else {
    console.log("Exist but old -> continue");
  }

  console.log("Missing -> fetch")
  client.get(URL_PANDASCORE, function (data, response) {
    console.log("feed fetched");
    //const items = parseChannel(data.rss.channel)
    const items = cleanUp(data);

    return lastEdition
      .set({
        date: new Date(Date.now()).toISOString(),
        items: items
      })
      .then(function () {
        res.status(201)
          .type("application/json")
          .send(items);
      });
  });

}

function elapsed(date) {
  const then = new Date(date);
  const now = new Date(Date.now());
  return now.getTime() - then.getTime();
}

function cleanUp(data) {
  console.log("Cleaning up data: ", data);
  // Empty array to add clean up elements
  const items = [];
  // We are only interested in "channel" children
  // const channel = data.rss.channel

  // channel.item.forEach(element => {
  //     item = {
  //         title: element.title,
  //         description: element.description,
  //         date: element.pubDate,
  //         creator: element["dc:creator"],
  //         media: []
  //     }
  //     // Iterates through all the elements named "<media:content>" extracting the info we care about
  //     element["media:content"].forEach(mediaContent => {
  //         item.media.push({
  //             url: mediaContent.$.url,                // Parses media:content url attribute
  //             credit: mediaContent["media:credit"]._ // Parses media:cretit tag content
  //         })
  //     });
  //     items.push(item);
  // });
  return Promise.resolve(data);
}




// /// $$$$$$$$

// const functions = require("firebase-functions");

// // // Create and Deploy Your First Cloud Functions
// // // https://firebase.google.com/docs/functions/write-firebase-functions
// //
// // exports.helloWorld = functions.https.onRequest((request, response) => {
// //   functions.logger.info("Hello logs!", {structuredData: true});
// //   response.send("Hello from Firebase!");
// // });

// const PANDA_URL = "https://api.pandascore.co/rl";

// const Client = require("node-rest-client").Client;
// const client = new Client();

// // MARK: - Helper functions
// function request(url) {
//     return new Promise(function (fulfill, reject) {
//         client.get(url, function (data, response) {
//             fulfill(data);
//         });
//     })
// }

// function response(res, items, code) {
//     return Promise.resolve(res.status(code)
//         .type("application/json")
//         .send(items));
// }

// function save(path, items) {
//     return admin.database().ref("/leagues")
//         .set({ items: items })
//         .then(() => {
//             return Promise.resolve(items);
//         });
// }

// // MARK

// // Get RL Leagues
// exports.getLeagues = functions.https.onRequest((req, res) => {
//     const path = "/leagues";
//     return request({
//         url: PANDA_URL + path,
//         headers: {
//             "Authorization": "Bearer ${functions.config().pandascore.key}"
//         }
//     })
//     .then(data)
//     .then(items => save("/leagues", items))
//     .then(items => response(res, items, 201));
// })
