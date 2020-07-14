let map, nav, center;
let markers = [];

//Define the map and configure the map's theme
window.initMap = function() {
  center = mapCenterCoordinates()
  console.log(center)

  $('#map').each((_, mapElement) => {
    map = new mapboxgl.Map({
        container: mapElement,
        attributionControl: false, //need this to show a compact attribution icon (i) instead of the whole text
        style: unwired.getLayer("streets"), //get Unwired's style template
        maxZoom: 11,
        zoom: 11,
        center: center
    });

    //Add Navigation controls to the map to the top-right corner of the map
    nav = new mapboxgl.NavigationControl();
    map.addControl(nav, 'top-left');
  });

  if (isHomePage()) map.scrollZoom.disable();

  loadMarkersFromPage() // Load search results from home page if any
  multiTouchSupport() // disable drapPan for mobile on single touch
};

window.generateMarkers = function(searchResultsList) {
    clearMarkers();
    searchResultsList.forEach(entry => {
      let coordinates = Object.values(entry.location); // coordinates
      let el = document.createElement('div'); // creating marker
      el.className = 'marker';

      let popup = new mapboxgl.Popup()
        .setHTML('<b>'+entry.name+'</b>'); // Popup with user name

      markers.push(
        new mapboxgl.Marker(el)
            .setLngLat(coordinates)
            .setPopup(popup)
            .addTo(map)
      );
    });

    centerMap();
};

function centerMap() {
    if (markers.length > 0) {
        const bounds = new mapboxgl.LngLatBounds();
        markers.forEach(marker => {
            bounds.extend(marker.getLngLat());
        });
        map.setMaxZoom(10);
        map.fitBounds(bounds);
    }
}

function clearMarkers() {
    markers.forEach(marker => {
       marker.remove();
    });
    markers = [];
}

function multiTouchSupport(){
  if ($(window).width() < 767) {

    map.dragPan.disable();
    map.scrollZoom.disable();

    map.on('touchstart', event => {
      const e = event.originalEvent;
      if (e && 'touches' in e) {
        if (e.touches.length > 1) {
          map.dragPan.enable();
        } else {
          map.dragPan.disable();
        }
      }
    });
  }
}

//Add your Unwired Maps Access Token here (not the API token!)
function setUnwiredApiToken(token) {
  unwired.key = mapboxgl.accessToken = token;
}

function loadMarkersFromPage(){
  if (window.searchResultsList.length > 0) generateMarkers(window.searchResultsList)
}

function mapCenterCoordinates(){
  return window.currentLatLng || [78.4008997, 17.4206485]
}

function isHomePage(){
  return location.pathname == "/"; // Equals true if we're at the root
}

$(document).on('turbolinks:load', () => {
    if ('mapboxgl' in window) {
        initMap();
    }
});

window.setUnwiredApiToken = setUnwiredApiToken;
