<cfscript>

	include "./partials/mixins.cfm";

	// ------------------------------------------------------------------------------- //
	// ------------------------------------------------------------------------------- //

	param name="url.token" type="regex" pattern=TOKEN_PARAM_REGEX;
	param name="form.action" type="string" default="";
	param name="form.rowID" type="numeric" default=0;

	data = application.dataGateway.read( url.token );

	if ( isPost() ) {

		switch ( form.action ) {
			case "toggleDrink":
				data.drinks[ form.rowID ].isSelected = ! data.drinks[ form.rowID ].isSelected;
			break;
			case "toggleMeal":
				data.meals[ form.rowID ].isSelected = ! data.meals[ form.rowID ].isSelected;
			break;
			case "toggleSnack":
				data.snacks[ form.rowID ].isSelected = ! data.snacks[ form.rowID ].isSelected;
			break;
		}

		application.dataGateway.write( url.token, data );

		// If the update is being made from HTMX, we can just let the page re-render since
		// we're going to be plucking parts of the UI out. However, if this is a regular
		// request, we want to refresh the page so the user doesn't accidentally re-submit
		// the form on page refresh.
		if ( ! isHtmx() ) {

			goto( postBackUrl() );

		}

	}

</cfscript>
<cfoutput>

	<h1>
		#withTitle( "Sitter Snacks" )#
	</h1>

	<h2>
		Contacts
	</h2>

	<cfif data.contacts.len()>

		<table border="1" cellpadding="5" cellspacing="1">
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

		<table border="1" cellpadding="5" cellspacing="1">
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
			<cfloop array="#data.drinks#" item="drink" index="rowID">
				<tr
					id="drink-#rowID#"
					class="#classNames({ isSelected: drink.isSelected })#">
					<td>
						#efh( drink.name )#
					</td>
					<td>
						#efh( drink.description )#
					</td>
					<td>

						<form
							method="post"
							hx-post="#postBackAction()#"
							hx-trigger="submit, click from:closest tr"
							hx-target="closest tr"
							hx-select="##drink-#rowID#"
							hx-swap="outerHTML"
							hx-sync="this">

							<input type="hidden" name="action" value="toggleDrink" />
							<input type="hidden" name="rowID" value="#efa( rowID )#" />

							<button type="submit">
								#yesNoFormat( drink.isSelected )#
							</button>
						</form>

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

		<table border="1" cellpadding="5" cellspacing="1">
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
			<cfloop array="#data.snacks#" item="snack" index="rowID">
				<tr
					id="snack-#rowID#"
					class="#classNames({ isSelected: snack.isSelected })#">
					<td>
						#efh( snack.name )#
					</td>
					<td>
						#efh( snack.description )#
					</td>
					<td>

						<form
							method="post"
							hx-post="#postBackAction()#"
							hx-trigger="submit, click from:closest tr"
							hx-target="closest tr"
							hx-select="##snack-#rowID#"
							hx-swap="outerHTML"
							hx-sync="this">

							<input type="hidden" name="action" value="toggleSnack" />
							<input type="hidden" name="rowID" value="#efa( rowID )#" />

							<button type="submit">
								#yesNoFormat( snack.isSelected )#
							</button>
						</form>

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

	<cfif data.meals.len()>

		<table border="1" cellpadding="5" cellspacing="1">
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
			<cfloop array="#data.meals#" item="meal" index="rowID">
				<tr
					id="meal-#rowID#"
					class="#classNames({ isSelected: meal.isSelected })#">
					<td>
						#efh( meal.name )#
					</td>
					<td>
						#efh( meal.description )#
					</td>
					<td>

						<form
							method="post"
							hx-post="#postBackAction()#"
							hx-trigger="submit, click from:closest tr"
							hx-target="closest tr"
							hx-select="##meal-#rowID#"
							hx-swap="outerHTML"
							hx-sync="this">

							<input type="hidden" name="action" value="toggleMeal" />
							<input type="hidden" name="rowID" value="#efa( rowID )#" />

							<button type="submit">
								#yesNoFormat( meal.isSelected )#
							</button>
						</form>
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
