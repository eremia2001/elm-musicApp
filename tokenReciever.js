var app = Elm.Home.init({
  node: document.getElementById("elm-root"),
});
let savedToken = null;
//getToken();
//getArtistData();
getData();

async function getToken() {
  var params = new URLSearchParams(window.location.search);
  const authCode = params.get("code");
  const authHeader =
    "95b88d3b5a5745748fb58777ed7a1318" +
    ":" +
    "b034a0268b7a498cadf494bc71501671";

  const headers = {
    Authorization: "Basic " + btoa(authHeader),
    "Content-Type": "application/x-www-form-urlencoded",
  };

  const body = new URLSearchParams();
  body.append("grant_type", "authorization_code");
  body.append("code", authCode);
  body.append("redirect_uri", "http://127.0.0.1:5500/home.html");

  const response = await fetch("https://accounts.spotify.com/api/token", {
    method: "POST",
    headers: headers,
    body: body.toString(),
  });

  const data = await response.json();
  //console.log(data);
  return data;
  // TODO: Add refresh Token ?
}

function getData() {
  getToken().then((token) => {
    savedToken = token;
    console.log("AKJSHD" + savedToken.access_token);
    // wird es dann aufgerufen , wenn sicher feststeht, dass token gespeichert ist.
    getArtistData();
  });
}

async function getArtistData() {
  const headers = {
    Authorization: "Bearer " + savedToken.access_token,
  };
  const response = await fetch(
    "https://api.spotify.com/v1/artists/0TnOYISbd1XYRBk9myaseg",
    {
      method: "GET",
      headers: headers,
    }
  )
    .then((response) => response.json())
    .then((data) => console.log(data));

  //const data = await response.json();
  //console.log(data);
  //console.log(response);
}
