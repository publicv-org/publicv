let map;
let markers = [];

window.initMap = function() {
    $('#map').each((_, mapElement) => {
        map = new google.maps.Map(mapElement, {
            center: {lat: 46.8182, lng: 8.2275},
            zoom: 7
        });
    });
};

window.generateMarkers = function(searchResultsList) {
    clearMarkers();
    searchResultsList.forEach(entry => {
        markers.push(
            new google.maps.Marker({
                position: entry.location,
                map: map,
                title: entry.name
            })
        );
    });

    centerMap();
};

function centerMap() {
    if (markers.length > 0) {
        const bounds = new google.maps.LatLngBounds();
        markers.forEach(marker => {
            bounds.extend(marker.getPosition());
        });
        map.fitBounds(bounds);
    }
}

function clearMarkers() {
    markers.forEach(marker => {
       marker.setMap(null);
    });
    markers = [];
}

$(document).on('turbolinks:load', () => {
    if ('google' in window) {
        initMap();
    }
});
