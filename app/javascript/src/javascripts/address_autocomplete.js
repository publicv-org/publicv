import {throttle} from "lodash";

let token;
let inputField, resultsContainer;

function initAutocomplete(modalId, api_token) {
    token = api_token;
    inputField = $(`#${modalId}_address`);
    resultsContainer = $(`#${modalId}_results`);

    autocomplete();
}

function autocomplete() {
    // Instead of sending a request on each keystroke, send one every second. (LocationIQ free limit: 2 req/s)
    let throttled = throttle(fetchData, 1000);
    inputField.on('input', throttled);

    // Make results clickable and auto-fill information
    resultsContainer.on('click', 'li', (event)=> {
       inputField.val($(event.target).text());
       resultsContainer.find('ul').empty();
       resultsContainer.hide();
    });
}

async function fetchData() {
    let data;
    let query = encodeURIComponent(inputField.val());
    let locale = window.currentLocale;
    let api_link = `https://api.locationiq.com/v1/autocomplete.php?key=${token}&q=${query}&normalizecity=0&limit=5&accept-language=${locale}`;
    // let api_link = `https://search-maps.yandex.ru/v1/text=${query}&type=geo&lang=it&results=5`

    if (inputField.val().length > 0) {
        try {
            let response = await fetch(api_link);
            data = await response.json();
        } catch(e) {
            $('.modal.fade.show').find('.alert.alert-danger').empty().append(e.message);
        }
    }

    displayResults(data);
}

function displayResults(data) {
    const resultsList = resultsContainer.find('ul');
    let formattedAddresses;

    if (inputField.val().length > 0) {
        resultsContainer.show();
    } else {
        resultsList.empty();
        resultsContainer.hide();
    }

    if (data && Array.isArray(data) && data.length > 0) {
        formattedAddresses = data.map(address => address.display_name);
        resultsList.empty();
        formattedAddresses.forEach(address => {
            resultsList.append(`<li><span><i class="fas fa-map-marker-alt"></i></span>${address}</li>`);
        });
        resultsList.append('<p>Search by <a href="https://locationiq.com" target="_blank">LocationIQ.com</a></p>');
    }
}

window.initAutocomplete = initAutocomplete;
