<script language="javascript">
 var docMarkers=[];	   
 var icon = new google.maps.MarkerImage("http://maps.google.com/mapfiles/ms/micons/green.png",
 new google.maps.Size(32, 32), new google.maps.Point(0, 0),
 new google.maps.Point(16, 32));
 var center = null;
 var map = null;
 var currentPopup;
 var bounds = new google.maps.LatLngBounds();

 //alert('outside');
 
		 
		 function addMarker(lat, lng, info,id) {
			 //alert('inside addmarker');
			 var pt = new google.maps.LatLng(lat, lng);
			 bounds.extend(pt);
				 var marker = new google.maps.Marker({
				 position: pt,
				 icon: icon,
				 ID: id,
				 map: map
				 });
			 
				 var popup = new google.maps.InfoWindow({
				 content: info,
				 maxWidth: 300
				 });
				 
		 google.maps.event.addListener(marker, "click", function() {
		 if (currentPopup != null) {
		 currentPopup.close();
		 currentPopup = null;
		 }
		 popup.open(map, marker);
		 currentPopup = popup;
		 });
		 
		 google.maps.event.addListener(popup, "closeclick", function() {
		 map.panTo(center);
		 currentPopup = null;
		 });
		 
		 
		 //adding animation to markers
		 //marker.setAnimation(google.maps.Animation.DROP);
		 //marker.setAnimation(google.maps.Animation.BOUNCE);
		 //marker.set("id", id);//set ids to each marker
		 //push marker in an array defined with global scope
		 docMarkers[id] = marker;
		 //console.log(docMarkers);
		 //alert(marker.ID);
		 //print_r(markers[id]);
		 //alert(markers.join('\n'));
		 //alert();
		 }
		  
		  
		  
		  function initMap() {
		 //alert('inside initMap');
				//this array will store the marker ids
				 //var markers = [];
				 //markers['0']='yo';
				 //alert();
				 map = new google.maps.Map(document.getElementById("map"), {
				 center: new google.maps.LatLng(0, 0),
				 zoom: 14,
				 mapTypeId: google.maps.MapTypeId.ROADMAP,
				 mapTypeControl: false,
				 mapTypeControlOptions: {
				 style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR
				 },
				 navigationControl: true,
				 navigationControlOptions: {
				 style: google.maps.NavigationControlStyle.SMALL
				 }
				 });
				 <?php
				/* $db=new Database();
					$db->connect();
					$db->select('googlemap','id,description,address,lat,lng',NULL,'1');
					$res=$db->getResult();
					
					$count=count($res);
					for($i=0;$i<$count;$i++)
					{
					   $name=$res[$i]['id'];
					   $lat=$res[$i]['lat'];
					   $lon=$res[$i]['lng'];
					   $desc=$res[$i]['description'];
					   echo ("addMarker($lat, $lon,'<b>$name</b><br/>$desc',$id);\n");
					}
					$db->disconnect(); */
					 for($i=0;$i<$NumberofDoctors;$i++)
				    {
					  $id=$AllDoctorSchedules[$i]['doc_id'];
					  $name=$AllDoctorSchedules[$i]['FirstName'];
					  $lat=$AllDoctorSchedules[$i]['lat'];
					  $lon=$AllDoctorSchedules[$i]['lng'];
					  $desc=$AllDoctorSchedules[$i]['speciality'];
					  echo ("addMarker($lat, $lon,'<b>$name</b><br/>$desc',$id);\n");
					}
				 ?>
		 center = bounds.getCenter();
		 map.fitBounds(bounds);
		 //alert('init map function end');
		 //console.log(docMarkers);
		 //alert('init map ends');
		 }
		 
 function mouseoverSearchDiv(doc_id){
//alert(doc_id);
//alert('Onmouseover');
docMarkers[doc_id].setAnimation(google.maps.Animation.BOUNCE);
}
function mouseoutSearchDiv(doc_id){ 
//console.log(doc_id);
//alert("Mouseover");
docMarkers[doc_id].setAnimation(google.maps.Animation.NONE);
}


//document.getElementById("header").addEventListener("mouseover",onMouseover,false);

//document.getElementById("header").addEventListener("mouseout",onMouseout,false);
	 
		 
	</script>