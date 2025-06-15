<cfscript>

	include "./partials/mixins.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.token" type="regex" pattern=TOKEN_PARAM_REGEX;

	data = application.dataGateway.read( url.token );

</cfscript>
<cfoutput>

	<h1>
		#withTitle( "Sitter Snacks" )#
	</h1>

	<h2>
		Contacts
	</h2>

	<cfif data.contacts.len()>

		<table border="1" cellpadding="5">
		<thead>
			<tr>
				<th>
					Name
				</th>
				<th>
					Phone
				</th>
				<th>
					Email
				</th>
				<th>
					Primary
				</th>
			</tr>
		</thead>
		<tbody>
			<cfloop array="#data.contacts#" item="contact">
				<tr>
					<td>
						#efh( contact.name )#
					</td>
					<td>
						#efh( contact.phone )#
					</td>
					<td>
						#efh( contact.email )#
					</td>
					<td>
						<cfif contact.isPrimary>
							Yes
						</cfif>
					</td>
				</tr>
			</cfloop>
		</tbody>
		</table>

	</cfif>

	<p>
		<cfif ! data.contacts.len()>
			You have no contacts.
		</cfif>
		<a href="./contacts.cfm?token=#efu( url.token )#">Edit contacts</a> &rarr;
	</p>

	<hr />

	<h2>
		Drinks
	</h2>

	<cfif data.drinks.len()>

		<table border="1" cellpadding="5">
		<thead>
			<tr>
				<th>
					Name
				</th>
				<th>
					Description
				</th>
				<th>
					Selected
				</th>
			</tr>
		</thead>
		<tbody>
			<cfloop array="#data.drinks#" item="drink">
				<tr>
					<td>
						#efh( drink.name )#
					</td>
					<td>
						#efh( drink.description )#
					</td>
					<td>
						#yesNoFormat( drink.isSelected )#
					</td>
				</tr>
			</cfloop>
		</tbody>
		</table>

	</cfif>

	<p>
		<cfif ! data.drinks.len()>
			You have no drinks.
		</cfif>
		<a href="./drinks.cfm?token=#efu( url.token )#">Edit drinks</a> &rarr;
	</p>

	<hr />

	<h2>
		Snacks
	</h2>

	<cfif data.snacks.len()>

		<table border="1" cellpadding="5">
		<thead>
			<tr>
				<th>
					Name
				</th>
				<th>
					Description
				</th>
				<th>
					Selected
				</th>
			</tr>
		</thead>
		<tbody>
			<cfloop array="#data.snacks#" item="snack">
				<tr>
					<td>
						#efh( snack.name )#
					</td>
					<td>
						#efh( snack.description )#
					</td>
					<td>
						#yesNoFormat( snack.isSelected )#
					</td>
				</tr>
			</cfloop>
		</tbody>
		</table>

	</cfif>

	<p>
		<cfif ! data.snacks.len()>
			You have no snacks.
		</cfif>
		<a href="./snacks.cfm?token=#efu( url.token )#">Edit snacks</a> &rarr;
	</p>

	<hr />

	<h2>
		Meals
	</h2>

	<cfif data.snacks.len()>

		<table border="1" cellpadding="5">
		<thead>
			<tr>
				<th>
					Name
				</th>
				<th>
					Description
				</th>
				<th>
					Selected
				</th>
			</tr>
		</thead>
		<tbody>
			<cfloop array="#data.meals#" item="meal">
				<tr>
					<td>
						#efh( meal.name )#
					</td>
					<td>
						#efh( meal.description )#
					</td>
					<td>
						#yesNoFormat( meal.isSelected )#
					</td>
				</tr>
			</cfloop>
		</tbody>
		</table>

	</cfif>

	<p>
		<cfif ! data.meals.len()>
			You have no meals.
		</cfif>
		<a href="./meals.cfm?token=#efu( url.token )#">Edit meals</a> &rarr;
	</p>

	<hr />
	<hr />

	<p>
		<a href="./index.cfm?init=1">Re-init</a>
	</p>

</cfoutput>
