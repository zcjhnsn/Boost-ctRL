const ONE_DAY = 86400000;
const SIX_HOURS = 21600000;
const ONE_HOUR = 3600000;
const FIVE_MINS = 300000;

const functions = require("firebase-functions");

let URL_PANDASCORE = "https://api.pandascore.co/rl";
const PATH_LEAGUES = "/leagues";
const TOKEN_URL = "?token=" + functions.config().pandascore.key
const URL_ROCKETEERS = "https://rocketeers.gg/wp-json/wp/v2/posts?per_page=10&_embed="
const URL_OCTANE_NEWS = "https://api.octane.gg/api/news_section"
const URL_OCTANE_EVENTS_ARCHIVE = "https://api.octane.gg/api/event_list"
const URL_OCTANE_EVENTS_UPCOMING = "https://api.octane.gg/api/event_list/upcoming"

const Client = require("node-rest-client").Client;
const client = new Client();

const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);


// MARK: - EVENTS

exports.getEvents = functions.https.onRequest((req, res) => {

});


// MARK: - News APIs

// Retrieves articles from rocketeers.gg and caches them in Firebase
exports.getRocketeersArticles = functions.https.onRequest((req, res) => {
  console.log("Fetching Rocketeers news");
  var rocketeers = admin.database().ref("/news/rocketeers");
  return rocketeers
    .once("value")
    .then(snapshot => {
      if (isCacheValid(snapshot, ONE_HOUR)) {
        console.log("Rocketeers is still valid")
        return response(res, snapshot.val(), 200);
      } else {
        return request(URL_ROCKETEERS)
          .then(data => cleanUpRocketeers(data))
          .then(items => save(rocketeers, items))
          .then(items => response(res, items, 201));
      }
    });
});

// Retrieves articles from octane.gg and caches them in Firebase
exports.getOctaneArticles = functions.https.onRequest((req, res) => {
  console.log("Fetching Octane news");
  var octane = admin.database().ref("/news/octane");
  return octane
    .once("value")
    .then(snapshot => {
      if (isCacheValid(snapshot, ONE_HOUR)) {
        console.log("Octane is still valid")
        return response(res, snapshot.val(), 200);
      } else {
        return request(URL_OCTANE_NEWS)
          .then(data => cleanUpOctane(data))
          .then(items => save(octane, items))
          .then(items => response(res, items, 201));
      }
    });
});

// MARK: - LEAGUES

// Retrieves leagues from 
exports.getLeagues = functions.https.onRequest((req, res) => {
  console.log("Fetching The Leagues");
  var leagues = admin.database().ref("/leagues");
  return leagues
    .once("value")
    .then(snapshot => {
      if (isCacheValid(snapshot, ONE_DAY)) {
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
      expires: new Date(Date.now()).toISOString(),
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

function isCacheValid(snapshot, timeConstant) {
  return (
    snapshot.exists() &&
    elapsed(snapshot.val().expires) < timeConstant
  );
}

function elapsed(date) {
  const then = new Date(date);
  const now = new Date(Date.now());
  return now.getTime() - then.getTime();
}

// MARK: - Clean Up functions

// Clean up rocketeers.gg's gross WordPress response
function cleanUpRocketeers(dataResponse) {
  const items = [];
  dataResponse.forEach(element => {
    item = {
      id: element.id,
      date: element.date_gmt,
      link: element.link,
      title: element.title.rendered,
      image: element["_embedded"]["wp:featuredmedia"][0].media_details.sizes.large.source_url
    };

    items.push(item);
  });

  return Promise.resolve(items);
}

// Cleans up Octane.gg's API response.
function cleanUpOctane(dataResponse) {
  const items = [];
  dataResponse.data.forEach(element => {
    item = {
      id: element.id,
      date: element.Date,
      link: "https://octane.gg/news/" + element.link,
      title: element.Title,
      image: element.Image
    };

    items.push(item);
  });

  return Promise.resolve(items);
}

function cleanOctaneArchiveMatches(dataResponse, items) {
  const newItems = items

  dataResponse.data.forEach(element => {
    item = {
      event: element.Event,
      startDate: element.start_date,
      endDate: element.end_date,
      region: element.region,
      location: element.location,
      country: element.country,
      prize: element.prize,
      currency: element.currency,
      type: element.type,
      eventHyphenated: element.eventHyphenated,
      stages: element.stages
    };

    newItems.push(item);
  });

  return Promise.resolve(newItems);
}


function cleanOctaneUpcomingMatches(dataResponse, items) {
  const newItems = items

  dataResponse.data.forEach(element => {
    item = {
      event: element.Event,
      startDate: element.start_date,
      endDate: element.end_date,
      region: element.region,
      location: element.location,
      country: element.country,
      prize: element.prize,
      currency: element.currency,
      type: element.type,
      eventHyphenated: element.eventHyphenated,
      stages: element.stages
    };

    newItems.push(item);
  });

  return Promise.resolve(newItems);
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