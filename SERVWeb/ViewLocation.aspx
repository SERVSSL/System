<%@ Page Language="C#" Inherits="SERVWeb.ViewLocation" MasterPageFile="~/Master.master" %>
<%@ MasterType VirtualPath="~/Master.master" %>
<asp:Content ContentPlaceHolderID="titlePlaceholder" ID="titlePlaceholderContent" runat="server">Location</asp:Content>
<asp:Content ContentPlaceHolderID="contentPlaceholder" ID="contentPlaceholderContent" runat="server">

	<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDv-Wccd0zvGm6GyENJJs7d3lQNmysym9o"></script>

	<div id="entry" style="display:none">
		<h3>View / Edit Location: <span id="lblTitle"></span></h3>
		<div class="row">
			<div class="span6">
				<div class="alert">
				  <button type="button" class="close" data-dismiss="alert">&times;</button>
				  <strong>Warning!</strong> Do not rename old or redundant locations to make new ones!!<br/>
				  That would cause any runs that went to or from the old location to show that they went to or from what you rename it to.
				</div>
			</div>
		</div>

		<div class="row">

			<fieldset>
				<div class="span3">
				
					<label>Location Name:</label>
					<input type="text" id="txtLocationName" />

					<div class="checkbox">
						<label>
							<input type="checkbox" id="chkHospital" /> Hospital
						</label>
						<label>
							<input type="checkbox" id="chkBloodBank" /> Blood Bank
						</label>
						<label>
							<input type="checkbox" id="chkChangeOver" /> Changeover
						</label>

						<label>
							<input type="checkbox" id="chkInNetwork" /> In Network
						</label>

					</div>

					<label>Location:</label>
					<input type="text" id="txtLat" />	<input type="text" id="txtLng" />	
					<label>Postcode:</label>
					<input type="text" id="txtPostCode" />

					<label>What 3 words:</label>
					<input type="text" id="txtWhat3Words" />
					<div id="what3words">
						
                    </div>

					<div id="map_canvas" class="img-rounded" style="width:500px; height:350px; border:1px solid gainsboro; margin-top: 10px; margin-bottom: 10px;">
					</div>

				</div>
			</fieldset>

		</div>

		<br/>
		<button type=button id="cmdSave" class="btn btn-primary btn-lg readOnlyHidden" onclick="_SaveLocation()"><i class="icon-ok icon-white"></i> Save</button>

	</div>

	<script>

	$(function() 
	{
		if ("<%=this.Message%>" != "") { niceAlert("<%=this.Message%>"); }
        if (<%=this.UserLevel%> < <%=(int)SERVDataContract.UserLevel.Controller%>) 
		{
			$("#cmdSave").slideUp();
		}
		DisplayLocation(<%=this.LocationId%>);
	});

	function _SaveLocation()
	{
		SaveLocation(<%=this.LocationId%>);
	}

	function initializeMap() {
						
		var myLatlng = new google.maps.LatLng(51.501974479325135,-0.13295898437502274);
		
		var dbLat = $("#txtLat").val();
		var dbLng = $("#txtLng").val();
		if(dbLat.length > 0)
		{
			myLatlng = new google.maps.LatLng(dbLat, dbLng);
		}
		
		var mapOptions = {
			center: myLatlng,
			zoom: 16,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		};
		
		var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
		
		var marker = new google.maps.Marker({
			position: myLatlng,
			map: map,
			draggable: true,
			title:"Location"
		});
		
		google.maps.event.addListener(marker, 'dragend', function(event) {
			$("#txtLat").val(event.latLng.lat());
			$("#txtLng").val(event.latLng.lng());
			map.setCenter(event.latLng);
		});
		
	}
	
	</script>

</asp:Content>


