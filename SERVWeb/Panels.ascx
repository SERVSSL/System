<%@ Control Language="C#" Inherits="SERVWeb.Panels" %>
<%@ Import Namespace="SERVWeb" %>

<div id="loading">
    <p><button class="btn btn-warning"><i class="icon-time icon-white"></i> <span id="lblLoading">Please wait . . .</span></button></p>
</div>

<div id="error" style="display:none">
	<div class="row">
		<div class="span3" id="errorImg">
			<img id="imgError" class="img-rounded" src="" width="200"/><br/>
		</div>
		<div class="span9">
			<h4>Sorry, something went wrong</h4>
			<br/>
			<p>Your session may have timed out, or you <i>may</i> have discovered a bug.</p>
			<p>If this keeps happening, please contact your support bod.</p>
		</div>
	</div>
	<br/>
</div>

<div id="success" style="display:none" class="hero-unit">
	<h2>Success!</h2>	
	<p><span id="successMessage">Super . . .</span> </p>	
	<!--<button id="cmdAgain" type=button class="btn btn-success btn-lg" onclick="window.location.href=window.location.href;">Again Please!</button>-->
</div>

<div id="message" style="display:none" class="hero-unit">
	<h2>Please note:</h2>	
	<p><span id="successMessage"><span id="lblMessage"></span></span></p>	
</div>

<div id="alert" style="display:none" title="SERV">
	<p><span id="alertMessage">Default message</span></p>
</div>

<div id="pnlReadOnly" class="alert" style="display:none" title="SERV">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>CAUTION!</strong> <%=SERVGlobal.SystemName%> is currently in <strong>Read Only mode</strong>.  You will not be able to save any changes.
</div>

<script>

	$("#imgError").attr('src', getErrorImage());



</script>

<!--
<div class="alert">
  <button type="button" class="close" data-dismiss="alert">&times;</button>
  <strong>CAUTION!</strong> A release will be performed in the next <strong>30 minutes</strong>!!<br/>
  When the new code is released, your session will be terminated. <strong>Any unsaved entries you have made will be lost.</strong>
</div>
  -->