<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Find a route using Geolocation and Google Maps API</title>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
        <script>
      function calculateRoute(from, to) {
        // Center initialized to Naples, Italy
        var myOptions = {
          zoom: 10,
          center: new google.maps.LatLng(35.22, -80.84),
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        // Draw the map
        var mapObject = new google.maps.Map(document.getElementById("map"), myOptions);
        var directionsService = new google.maps.DirectionsService();
        var directionsRequest = {
          origin: from,
          destination: to,
          travelMode: google.maps.DirectionsTravelMode.DRIVING,
          unitSystem: google.maps.UnitSystem.IMPERIAL
        };
        var directionsDisplay = new google.maps.DirectionsRenderer();
        mapcanvas = new google.maps.Map(document.getElementById("map"));
        directionsDisplay.setPanel(document.getElementById("directions"));
        directionsDisplay.setMap(mapcanvas);
        
        directionsService.route(
          directionsRequest,
          function(response, status)
          {
            if (status == google.maps.DirectionsStatus.OK)
            {
             directionsDisplay.setDirections(response);
             computeTotalDistance(response);
            }
            else
              $("#error").append("Unable to retrieve your route<br />");
          }
        );
      }
      
      function computeTotalDistance(result) {
            var total = 0;
            var myroute = result.routes[0];
            //alert(result.routes[0].legs[0].start_address);
            for (i = 0; i < myroute.legs.length; i++) {
              total += myroute.legs[i].distance.value;
            }
            //alert(result.routes[0].legs[i-1].end_address);
            total = total / 1609.344;
            document.getElementById("from").setAttribute("Value",result.routes[0].legs[0].start_address);
            document.getElementById("to").setAttribute("Value",result.routes[0].legs[i-1].end_address);
            document.getElementById("total").innerHTML = total + " miles";
            document.getElementById("distance").setAttribute("Value", total);
            document.getElementById("szip").setAttribute("Value",$.getZip(result.routes[0].legs[0].start_address));
            document.getElementById("dzip").setAttribute("Value",$.getZip(result.routes[0].legs[i-1].end_address));
            return total;
          }
        
        $.urlParam = function(name){
            var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
            if (results==null){
               return null;
            }
            else{
               return results[1] || 0;
            }
        }
        
         $.getZip = function(name){
            var Zip = name.split(",");
            var lenZip = Zip.length;
            if (Zip[lenZip-2]!=null){
            var tZip = Zip[lenZip-2].split(" "); 
               return tZip[2] || 0;
            }
        }
 
        $(document).ready(function() {
        // If the browser supports the Geolocation API
        if (typeof navigator.geolocation == "undefined") {
          $("#error").text("Your browser doesn't support the Geolocation API");
          return;
        }
                calculateRoute($.urlParam('from'), $.urlParam('to'));
      });
    </script>
    <style type="text/css">
      #map {
        width: 500px;
        height: 750px;
        margin-top: 10px;
      }
    </style>
  </head>
  <body>
      <table><tr>
              <td> <div id="map"></div></td>
              <td><div id="directions"></div></td>   
      </tr></table>
    <p id="total"></p>
    <p id="error"></p>
   
   <p id="DistanceData"></p>
    <form id="findDriver" name="calculate-route" action="selectDriver" method="get">
      <input type="hidden" id="from" name="from" required="required" />
      <input type="hidden" id="to" name="to" required="required" />
      <input type="hidden" id="distance" name="distance" required="required" />
      <input type="hidden" id="szip" name="szip" required="required" />
      <input type="hidden" id="dzip" name="dzip" required="required" />
      <br />
       
      <input type="submit" value="Search for Drivers" />
    </form>
  </body>
</html>
