let map, nav, center;
let markers = [];

//Define the map and configure the map's theme
window.initMap = function () {
  center = mapCenterCoordinates()
  console.log(center)

  $('#map').each((_, mapElement) => {
    locationiqKey = ApiToken;
    map = new mapboxgl.Map({
      container: mapElement,
      attributionControl: false, //need this to show a compact attribution icon (i) instead of the whole text
      style: 'https://tiles.locationiq.com/v2/streets/vector.json?key=' + locationiqKey, //get Unwired's style template
      maxZoom: 11,
      zoom: 4,
      center: center
    });

    //Add Navigation controls to the map to the top-right corner of the map
    nav = new mapboxgl.NavigationControl();
    map.addControl(nav, 'top-left');
  });
  ////cluster
  loadClusterFromPage()
  ////.........cluster

  if (isHomePage()) map.scrollZoom.disable();

 // loadMarkersFromPage() // Load search results from home page if any
  multiTouchSupport() // disable drapPan for mobile on single touch
};
////cluster defination..
window.generateClusters = function (searchResultsList) {
  map.on('load', function () {
    map.addSource('cluster_marker', {
      type: 'geojson',
      data: {
        "type": "FeatureCollection",
        "features": searchResultsList
      },  //Loading data to make cluster
      cluster: true,
      clusterMaxZoom: 14, // Max zoom to cluster points on
      clusterRadius: 50 // Radius of each cluster when clustering points (defaults to 50)
    });

    clusterLayer()           //Cluster make circle on the basis of point count of Cvs
    clusterCountLayer()      // Showing the number on cluster
    unclusteredPointLayer()  // Uncluster coordinates
    clusterOnClick()         // inspect a cluster on click
    unClusterOnClick()
  });

}


  function clusterLayer() {
    map.addLayer({
      id: 'clusters',
      type: 'circle',
      source: 'cluster_marker',
      filter: ['has', 'point_count'],
      paint: {
        // with three steps to implement three types of circles:
        //   * Blue, 20px circles when point count is less than 2
        //   * Yellow, 30px circles when point count is between 3 and 4
        //   * Pink, 40px circles when point count is greater than or equal to 4
        'circle-color': [
          'step',
          ['get', 'point_count'],
          '#51bbd6',
          2,
          '#f1f075',
          4,
          '#f28cb1'
        ],
        'circle-radius': [
          'step',
          ['get', 'point_count'],
          20,
          2,
          30,
          4,
          40
        ]
      }
    });
  }

  function clusterCountLayer() {
    map.addLayer({
      id: 'cluster-count',
      type: 'symbol',
      source: 'cluster_marker',
      filter: ['has', 'point_count'],
      layout: {
        'text-field': '{point_count_abbreviated}',
        'text-font': ['DIN Offc Pro Medium', 'Arial Unicode MS Bold'],
        'text-size': 20
      }
    });
  }

  function unclusteredPointLayer() {
    map.addLayer({
      id: 'unclustered-point',
      type: 'circle',
      source: 'cluster_marker',
      filter: ['!', ['has', 'point_count']],
      paint: {
        'circle-color': '#11b4da',
        'circle-radius': 8,
        'circle-stroke-width': 1,
        'circle-stroke-color': '#ffg'
      }
    });
  }

  function clusterOnClick() {
    map.on('click', 'clusters', function (e) {
      var features = map.queryRenderedFeatures(e.point, {
        layers: ['clusters']
      });
      var clusterId = features[0].properties.cluster_id;
      map.getSource('cluster_marker').getClusterExpansionZoom(
        clusterId,
        function (err, zoom) {
          if (err) return;

          map.easeTo({
            center: features[0].geometry.coordinates,
            zoom: zoom
          });
        }
      );
    });
  }

  function unClusterOnClick() {
    map.on('click', 'unclustered-point', function (searchResultsList) {
      var coordinates = searchResultsList.features[0].geometry.coordinates.slice();
      var name = searchResultsList.features[0].properties.name;
      var subdomain = searchResultsList.features[0].properties.subdomain;

      new mapboxgl.Popup()
        .setLngLat(coordinates)
        .setHTML('<a href="/cv/' + subdomain + '">' + name + '</a>')
        .addTo(map);
    });
  }

  function loadClusterFromPage() {
    if (window.searchResultsList.length > 0) generateClusters(window.searchResultsList)
  }

///cluster............

window.generateMarkers = function (searchResultsList) {
  clearMarkers();
  searchResultsList.forEach(entry => {
    let coordinates = Object.values(entry.location); // coordinates
    let el = document.createElement('div'); // creating marker
    el.className = 'marker';

    let popup = new mapboxgl.Popup()
      .setHTML('<a href="/cv/' + entry.subdomain + '">' + entry.name + '</a>'); // Popup with user name
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

function multiTouchSupport() {
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

function loadMarkersFromPage() {
  if (window.searchResultsList.length > 0) generateMarkers(window.searchResultsList)
}

function mapCenterCoordinates() {
  return window.currentLatLng || [78.4008997, 17.4206485]
}

function isHomePage() {
  return location.pathname == "/"; // Equals true if we're at the root
}

$(document).on('turbolinks:load', () => {
  if ('mapboxgl' in window) {
    initMap();
  }
});

window.setUnwiredApiToken = setUnwiredApiToken;