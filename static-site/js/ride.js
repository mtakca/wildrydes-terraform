const map = L.map('map').setView([47.6174, -122.2884], 14);

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '© OpenStreetMap contributors'
}).addTo(map);

let pickupLocation = null;
let marker = null;

map.on('click', function (e) {
    pickupLocation = { Latitude: e.latlng.lat, Longitude: e.latlng.lng };

    if (marker) map.removeLayer(marker);
    marker = L.marker(e.latlng).addTo(map);

    document.getElementById('status').textContent = 'Pickup location set. Click Request Unicorn.';
    document.getElementById('request').disabled = false;
});

document.getElementById('request').addEventListener('click', async function () {
    if (!pickupLocation) return;

    const token = sessionStorage.getItem('idToken');
    if (!token) {
        window.location.href = '/signin.html';
        return;
    }

    this.disabled = true;
    document.getElementById('status').textContent = 'Requesting unicorn...';

    try {
        const response = await fetch(`${window._config.api.invokeUrl}/ride`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': token
            },
            body: JSON.stringify({ PickupLocation: pickupLocation })
        });

        if (!response.ok) throw new Error('Request failed');

        const data = await response.json();

        document.getElementById('unicorn-name').textContent = data.Unicorn.Name;
        document.getElementById('unicorn-color').textContent = data.Unicorn.Color;
        document.getElementById('unicorn-eta').textContent = data.Eta;
        document.getElementById('unicorn-info').classList.remove('hidden');
        document.getElementById('status').textContent = 'Unicorn dispatched!';

    } catch (error) {
        document.getElementById('status').textContent = 'Error: ' + error.message;
        this.disabled = false;
    }
});

document.getElementById('signout').addEventListener('click', function (e) {
    e.preventDefault();
    sessionStorage.clear();
    window.location.href = '/';
});
