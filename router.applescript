-- the process name of PG
property process_name : "r131"

-- the exact names of the routes as shown in the Route dropdown
property escape_route : "Escape"
property repair_route : "Repair"
property farm_route : "Farm"

-- we'll repair when any item's durability is lower than...
property durability_threshold : 0.5


script router
	--click_button("Bot")
	--select_route(farm_route)
	repair_time()
end script

run router

-- methods

on click_button(button_name)
	tell application "System Events"
		tell process process_name
			
		end tell
	end tell
end click_button

on select_route(route)
	tell application "System Events"
		tell process process_name
			click pop up button 3 of group "Route, Behavior, and Combat Profile" of group 1 of window 1
			click menu item route of menu 1 of pop up button 3 of group "Route, Behavior, and Combat Profile" of group 1 of window 1
		end tell
	end tell
end select_route

on repair_time()
	tell application "System Events"
		tell process process_name
			click button "Items" of tool bar 1 of window 1
			set location_button to button 7 of group 1 of table 1 of scroll area 1 of group 1 of window 1
			set items_table to table 1 of scroll area 1 of group 1 of window 1
			-- sort the items list by location
			click location_button
			set equipped to rows 1 through 16 of items_table
			
			if value of text field 7 of row 1 of items_table is not "Wearing" then
				click location_button
			end if
			
			set is_it_repair_time to false
			repeat with equipped_item in equipped
				set dura_string to value of text field 6 of equipped_item
				try
					set current_durability to word 1 of dura_string
					set max_durability to word 2 of dura_string
					if (current_durability / max_durability) < durability_threshold then
						set is_it_repair_time to true
					end if
				end try
			end repeat
			get is_it_repair_time
		end tell
	end tell
end repair_time
