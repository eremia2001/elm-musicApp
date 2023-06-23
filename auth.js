var app = Elm.Main.init({
  node: document.getElementById("elm-root"),
});

app.ports.authenticate.subscribe(function () {
  const token = authenticateWithSpotify();
  //console.log(token ? true : false);
  console.log(token);
  app.ports.tokenReceived.send(token);
});

function authenticateWithSpotify() {
  var clientId = "95b88d3b5a5745748fb58777ed7a1318";
  var redirectUri = "http://127.0.0.1:5500/home.html"; // Hier muss Ihre korrekte Redirect-URI stehen
  var scopes = "user-read-private user-read-email"; // Hier müssen die Scopes stehen, die Sie benötigen
  var url =
    "https://accounts.spotify.com/authorize" +
    "?response_type=code" +
    "&client_id=" +
    clientId +
    (scopes ? "&scope=" + encodeURIComponent(scopes) : "") +
    "&redirect_uri=" +
    encodeURIComponent(redirectUri);

  // We redirect the user to the Spotify authentication page
  window.location = url;

  // After the user was redirected back to our app, we can extract the token
  var params = new URLSearchParams(window.location.search);
  var code = params.get("code");
  return code;
}
// Das ist wenn man nur einen Account benutzen will
/*function authenticateOwnAccount() {
  var client_id = "95b88d3b5a5745748fb58777ed7a1318";
  var client_secret = "b034a0268b7a498cadf494bc71501671";

  var authOptions = {
    method: "POST",
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      Authorization: "Basic " + btoa(client_id + ":" + client_secret),
    },
    body: "grant_type=client_credentials",
  };

  fetch("https://accounts.spotify.com/api/token", authOptions)
    .then(function (response) {
      if (response.ok) {
        return response.json();
      } else {
        throw new Error("Fehler bei der Anfrage");
      }
    })
    .then(function (data) {
      var token = data.access_token;
      console.log("Token:", data);
    })
    .catch(function (error) {
      console.error("Fehler:", error);
    });
}
*/

function getHashParams() {
  var hashParams = {};
  var e,
    r = /([^&;=]+)=?([^&;]*)/g,
    q = window.location.hash.substring(1);
  while ((e = r.exec(q))) {
    hashParams[e[1]] = decodeURIComponent(e[2]);
  }
  console.log(windows.location);
}
