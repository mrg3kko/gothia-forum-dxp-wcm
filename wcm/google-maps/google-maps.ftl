<#--
	NOTE: this is not yet finished. Google requires an API-key for using Google Maps
	API-key in turn requires that billing has been enabled with a credit card.
	https://cloud.google.com/maps-platform/user-guide/

	Right now we are not migrating Google Maps due to this.
-->

<#assign portletNamespace = request["portlet-namespace"] >

<div id="${portletNamespace}map" style="height: 400px; margin-bottom: 1.5em; width: 100%;"></div>

<script>

	function ${portletNamespace}_initMap() {

		var placeTitle = '${placeTitle.data}';
		var streetAddress = '${streetAddress.data}';
		var zipCode = '${zipCode.data}';
		var city = '${city.data}';

		var address = streetAddress + ', ' + zipCode + ' ' + city;

		var geocoder = new google.maps.Geocoder();

		geocoder.geocode({ 'address': address}, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {

				${portletNamespace}_renderMap(results[0].geometry.location);
			}
			else {
				A.log('GeoCoder failed.');
			}
		});

	}

	function ${portletNamespace}_renderMap(latLng) {
		var mapDomNode = document.getElementById('${portletNamespace}map');

			var map = new google.maps.Map(mapDomNode, {
					center: latLng,
					mapTypeControl: true,
					mapTypeId: google.maps.MapTypeId.ROADMAP,
					navigationControl: true,
					scaleControl: true,
					streetViewControl: true,
					zoom: 14
			});

		var contentString = '<div id="${portletNamespace}content">' +
				'<div><strong>' + placeTitle + '</strong></div>' +
				'<div>' + streetAddress + '</div>' +
				'<div>' + zipCode + ' ' + city + '</div>' +
			'</div>';

		var infoWindow = new google.maps.InfoWindow({
			content: contentString
		});

			var marker = new google.maps.Marker({
				position: latLng,
				map: map,
				title: placeTitle
		});

		google.maps.event.addListener(marker, 'click', function() {
			infoWindow.open(map, marker);
		});

		// Launch info window
		//google.maps.event.trigger(marker, 'click');
		infoWindow.open(map, marker);
	}


</script>

<#-- TODO: replace with key for Gothia -->
<script async defer src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&callback=" + ${portletNamespace} + "_initMap"></script>
