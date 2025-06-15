<cfscript>

	include "./partials/mixins.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="form.email" type="string" default="";

	if ( isPost() ) {

		token = application.dataGateway.setup( form.email.trim() );

		goto( "manifest.cfm?token=#efu( token )#" );

	}

</cfscript>
<cfoutput>

	<h1>
		#withTitle( "Sitter Snacks" )#
	</h1>

	<form method="post" action="#postBackAction()#">
		<p>
			<label>Email:</label><br />
			<input type="text" name="email" value="" maxlength="75" />
		</p>

		<button type="submit">
			Create a Snacktacular!
		</button>
	</form>

</cfoutput>
